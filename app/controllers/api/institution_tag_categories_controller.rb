class Api::InstitutionTagCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  def create
    @category = InstitutionTagCategory.new(category_params)
    if @category.save
      respond_with @category
    else
      p @category.errors
      return not_saved
    end
  end

  def show
    respond_with @category
  end

  def update
    if @category.update(category_params)
      respond_with @category
    else
      p @category.errors
      return not_saved
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'Institution Tag Category deleted' }, status: 200
  end

  def index
    @categories = InstitutionTagCategory.all
  end

  private

  def set_category
    @category = InstitutionTagCategory.find(params[:id])
    return not_found unless @category
  end

  def category_params
    params[:institution_tag_category].permit(
        :title,
        :origin
    )
  end
end
