class WelcomeController < ApplicationController
  skip_filter :authenticate

  def home
    @username="Mukesh"
  end

  def index
  	puts "I am inside WelcomeController.index"
  end

  def is_server_alive
  	render :nothing => true
  end

  def plain_text_response
  	respond_to do |request_format|
  		result = {:code => 200, :body => "OK"}
  		request_format.html { render :plain => "OK" }
  		request_format.json { render :json => result }
  		request_format.xml { render :xml => result }
  	end
  end
end
