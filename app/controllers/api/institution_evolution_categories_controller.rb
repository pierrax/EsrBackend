class Api::InstitutionEvolutionCategoriesController < Api::BaseController
  before_action :set_category, except: %i[create index]

  def create
    @category = InstitutionEvolutionCategory.new(category_params)
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
      return not_saved
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'Institution Evolution Category deleted' }, status: 200
  end

  def index
    @categories = InstitutionEvolutionCategory.all
    respond_with @categories
  end

  private

  def set_category
    @category = InstitutionEvolutionCategory.find(params[:id])
    return not_found unless @category
  end

  def category_params
    params[:institution_evolution_category].permit(
        :title
    )
  end
end
