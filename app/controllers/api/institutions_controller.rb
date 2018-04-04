class Api::InstitutionsController < Api::BaseController
  # before_action :authenticate, except: :create
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_institution, except: %i[create index]

  swagger_controller :institutions, "Les établissements de l'ESR"

  swagger_api :index do
    summary 'Returns all institutions'
    notes 'Tous les établissements de l ESR'
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      respond_with @institution
    else
      return not_found
    end
  end

  def show
    # respond_with @institution
  end

  def update
    if @institution.update(institution_params)
      # respond_with @institution
    else
      return not_found
    end
  end

  def destroy
    @institution.destroy
    render json: { message: 'Institution deleted' }, status: 200
  end

  def index
    @institutions = Institution.all
    respond_with @institutions
  end

  private

  def set_institution
    @institution = Institution.find(params[:id])
  end

  def institution_params
    params[:institution].permit(
        :esr_id,
        :date_start,
        :date_end
    )
  end

end
