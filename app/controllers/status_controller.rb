class ErrorStatusController < ApplicationController

  def status_403
    render file: "#{Rails.root}/public/403.html", layout: false
  end
end