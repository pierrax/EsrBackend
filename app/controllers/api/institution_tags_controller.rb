class Api::InstitutionTagsController < Api::BaseController
  before_action :set_tag, except: %i[create index]

  def create
    @tag = InstitutionTag.new(tag_params)
    if @tag.save
      respond_with @tag
    else
      p @tag.errors
      return not_saved
    end
  end

  def show
    respond_with @tag
  end

  def update
    if @tag.update(tag_params)
      respond_with @tag
    else
      p @tag.errors
      return not_saved
    end
  end

  def destroy
    @tag.destroy
    render json: { message: 'Institution Tag deleted' }, status: 200
  end

  def index
    @tags = InstitutionTag.all
  end

  private

  def set_tag
    @tag = InstitutionTag.find(params[:id])
    return not_found unless @tag
  end

  def tag_params
    params[:institution_tag].permit(
      :short_label,
      :long_label,
      :institution_tag_category_id,
      :date_start,
      :date_end,
      :status
    )
  end
end
