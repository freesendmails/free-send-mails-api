class Api::V1::MailController < ApplicationController
  def index
    render json: {success: true}, status: 200
  end
end
