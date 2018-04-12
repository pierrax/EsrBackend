class Api::InstitutionCategoryLabelsController < Api::BaseController
  before_action :set_category, except: %i[create index]

  def create
    @category_label = InstitutionCategoryLabel.new(institution_category_label_params)
    if @category_label.save
      respond_with @category_label
    else
      p @category_label.errors
      return not_saved
    end
  end

  def show
    respond_with @category_label
  end

  def update
    if @category_label.update(institution_category_label_params)
      respond_with @category_label
    else
      p @category_label.errors
      return not_saved
    end
  end

  def destroy
    @category_label.destroy
    render json: { message: 'Institution Category Label deleted' }, status: 200
  end

  def index
    @category_labels = InstitutionCategoryLabel.all
  end

  private

  def set_category
    @category_label = InstitutionCategoryLabel.find(params[:id])
    return not_found unless @category_label
  end

  def institution_category_label_params
    params[:institution_category_label].permit(
        :short_label,
        :long_label
    )
  end
end
