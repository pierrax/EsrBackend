class Api::InstitutionCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  def create
    @institution = Institution.find(params[:institution_id])
    @category = @institution.categories.new(category_params)
    if @category.save
      respond_with @category
    else
      return not_found
    end
  end

  def show
    respond_with @category
  end

  def update
    if @category.update(category_params)
      respond_with @category
    else
      return not_found
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'Institution Category deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @categories = @institution.categories
  end

  private

  def set_category
    @category = InstitutionCategory.find(params[:id])
  end

  def category_params
    params[:institution_category].permit(
        :institution_category_label_id,
        :date_start,
        :date_end,
        :status
    )
  end
end
