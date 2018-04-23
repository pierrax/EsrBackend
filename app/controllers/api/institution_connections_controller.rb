class Api::InstitutionConnectionsController < Api::BaseController

  def create_mother
    @institution = Institution.find(params[:institution_id])
    @connection = InstitutionConnection.new(mother_params)
    if @connection.save
      @connections = @institution.mother_connections
    else
      p @connection.errors
      return not_saved
    end
  end

  def index_mothers
    @institution = Institution.find(params[:institution_id])
    @mothers = @institution.mothers
    @connections = @institution.mother_connections
  end

  def destroy_mother
    @connection = InstitutionConnection.where(daughter_id: params[:institution_id], mother_id: params[:mother_id]).first
    return not_found unless @connection.present?
    @connection.destroy
    render json: { message: 'mother deleted' }, status: 200
  end

  def create_daughter
    @institution = Institution.find(params[:institution_id])
    @connection = InstitutionConnection.new(daughter_params)

    if @connection.save
      @connections = @institution.daughter_connections
    else
      p @connection.errors
      return not_saved
    end
  end

  def index_daughters
    @institution = Institution.find(params[:institution_id])
    @daughters = @institution.daughters
    @connections = @institution.daughter_connections
  end

  def destroy_daughter
    @connection = InstitutionConnection.where(mother_id: params[:institution_id], daughter_id: params[:daughter_id]).first
    return not_found unless @connection
    @connection.destroy
    render json: { message: 'daughter deleted' }, status: 200
  end

  private

  def mother_params
    params[:mother].permit(
        :mother_id,
        :institution_connection_category_id,
        :date
    ).merge(daughter_id: params[:institution_id])
  end

  def daughter_params
    params[:daughter].permit(
        :daughter_id,
        :institution_connection_category_id,
        :date
    ).merge(mother_id: params[:institution_id])
  end
end
