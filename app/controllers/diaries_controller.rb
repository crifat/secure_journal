class DiariesController < ApplicationController

  before_action :set_diary, only: [:destroy]
  before_action :authenticate_with_token!

  # GET /diaries
  def index
    @diaries = Diary.all

    render json: @diaries
  end

  # GET /diaries/1
  def show
    @result = Diary::Show.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  # POST /diaries
  def create
    @result = Diary::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  # PATCH/PUT /diaries/1
  def update
    @result = Diary::Update.(params)

    render json: @result['presenter.default'], status: @result['response.status']
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy
  end

  private
  def set_diary
    @diary = Diary.find(params[:id])
  end
    # Only allow a trusted parameter "white list" through.
    def diary_params
      params.require(:diary).permit(:name, :user_id)
    end
end
