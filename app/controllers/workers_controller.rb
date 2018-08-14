class WorkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_worker
    puts "params: #{params}"

    @user = User.find(params[:user_id])
    @worker = Worker.new(endpoint: params[:worker][:endpoint], p256dh: params[:worker][:p256], auth: params[:worker][:auth], user: @user)

    if @worker.save
      render json: { success: 'saved worker successfully' }
    else
      render json: { error: @worker.errors.full_messages }
    end
  end

  def push_notification
    puts "PUSH NOTIF GETTING CALLED"

    public_key = 'BLC8FDoQ4_xHUpyMhDUSSX4pyB5wlH16wiH3-jgMm2GfJGO0fs10CfVgEA8ZALw1HoyGbN32BqL5f0AnXPRHbgw'
    private_key = 'k_bZJEAt8XyT-DfQLs2gyzJhe2Vbjn6UnlneiPLi-ho'

    @user = User.find(params[:id])
    @user.workers.each do |w|
      Webpush.payload_send(
        endpoint: w.endpoint,
        message: 'helloooooo',
        p256dh: w.p256dh,
        auth: w.auth,
        vapid: {
          subject: "mailto:sender@example.com",
          public_key: public_key,
          private_key: private_key
        }
      )
    end
  end

end
