class CalculatorsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'calculate'

  before_filter :get_page

  def calculate
    @currency = params[:currency]
    @operation = params[:operation]
    @amount = params[:amount].to_i
    calculator = Calculate.new(@currency, @operation)
    calculator.get_result(@sale, @purchase, @amount)
    @result = calculator.format
  end

  private

  def get_page
    begin
      @url = params[:url]
      page = Nokogiri::HTML(open(@url))
      currensy = page.at('b:contains("UAH")').next.text.strip.split(' / ')
      @sale = currensy.first.to_f
      @purchase = currensy.second.to_f
    rescue
      render file: 'public/something_wrong'
    end
  end
end
