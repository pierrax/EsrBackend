class Api::InstitutionNamesController < Api::BaseController
  # before_action :authenticate, except: :create
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_institution_name, except: %i[create index]

  def create
    @institution = Institution.find(params[:institution_id])
    @institution_name = @institution.names.new(institution_name_params)
    if @institution_name.save
      @institution_name
    else
      return not_found
    end
  end

  def show
    respond_with @institution_name
  end

  def update
    if @institution_name.update(institution_name_params)
      respond_with @institution_name
    else
      return not_found
    end
  end

  def destroy
    @institution_name.destroy
    render json: { message: 'Institution deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @institution_names = @institution.names
  end

  private

  def set_institution_name
    @institution_name = InstitutionName.find(params[:id])
  end

  def institution_name_params
    params[:institution_name].permit(
        :text,
        :initials,
        :date_start,
        :date_end,
        :status
    )
  end
end
