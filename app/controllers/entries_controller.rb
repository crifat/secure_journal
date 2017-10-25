class EntriesController < ApplicationController
  before_action :set_entry, only: [:destroy]

  # GET /entries
  def index
    @entries = Entry.all

    render json: @entries
  end

  # GET /entries/1
  def show
    @result = Entry::Show.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  # POST /entries
  def create
    @result = Entry::Create.(params)
    render json: @result['presenter.default'], status: @result['response.status']
  end

  # PATCH/PUT /entries/1
  def update
    @result = Entry::Update.(params)

    render json: @result['presenter.default'], status: @result['response.status']
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def entry_params
      params.require(:entry).permit(:title, :body, :diary_id)
    end
end
