class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :update, :destroy]

  # GET /diaries
  def index
    @diaries = Diary.all

    render json: @diaries
  end

  # GET /diaries/1
  def show
    render json: @diary
  end

  # POST /diaries
  def create
    @result = Diary::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  # PATCH/PUT /diaries/1
  def update
    if @diary.update(diary_params)
      render json: @diary
    else
      render json: @diary.errors, status: :unprocessable_entity
    end
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def diary_params
      params.require(:diary).permit(:name, :user_id)
    end
end
