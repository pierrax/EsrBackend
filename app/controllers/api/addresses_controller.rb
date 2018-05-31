class Api::AddressesController < Api::BaseController
  # before_action :authenticate, except: :create
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_address, except: %i[create index import export]

  swagger_controller :addresses, 'Adresses des établissements'

  swagger_api :create do
    summary 'Create an address'
    notes 'Créer un adresse pour un établissement'
    param :integer, :institution_id, :integer, :required, 'Institution ID'
    param :body, :address, :json, :required, 'business_name address_1 address_2 zip_code city country phone date_start date_end'
  end

  swagger_api :index do
    summary 'Returns all addresses for an institution'
    notes 'Tous les adresses pour un établissement'
    param :query, :institution_id, :integer, :required, 'Institution ID'
  end

  swagger_api :show do
    summary 'Show a address'
    notes 'Afficher un adresse'
    param :query, :address_id, :integer, :required, 'address ID'
  end

  swagger_api :update do
    summary 'Update a address'
    notes 'Mettre à jour un adresse'
    param :query, :address_id, :integer, :required, 'address ID'
    param :body, :address, :json, :required, 'business_name address_1 address_2 zip_code city country phone date_start date_end'
  end

  swagger_api :destroy do
    summary 'Delete a address'
    notes 'Effacer un adresse'
    param :query, :address_id, :integer, :required, 'address ID'
  end

  swagger_api :import do
    summary 'Import addresses with CSV file'
    notes 'Créer / MAJ des adresses'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
    param :query, :file, :file, :required, 'CSV file'
  end

  swagger_api :export do
    summary 'Export addresses with CSV file'
    notes 'Créer / MAJ des adresses'
    param :header, 'Authentication-Token', :string, :required, 'Authentication token'
  end
  
  def create
    @institution = Institution.find(params[:institution_id])
    @address = @institution.addresses.create!(address_params)
    respond_with @address
  end

  def show
    respond_with @address
  end

  def update
    @address.update!(address_params)
    respond_with @address
  end

  def destroy
    @address.destroy
    render json: { message: 'Address deleted' }, status: 200
  end

  def index
    @institution = Institution.find(params[:institution_id])
    @addresses = @institution.addresses.page(params[:page_number]).per(params[:page_size])
    paginator @addresses, params.permit!
    respond_with @addresses
  end

  def import
    import_response = ImportAddresses.new(params[:file].tempfile).call
    if import_response == true
      render json: { message: 'Addresses uploaded' }, status: 200
    else
      render json: { message: import_response }, status: 401
    end
  end

  def export
    @addresses = Address.all
    export_csv = ExportAddresses.new(@addresses).call
    send_data export_csv, type: 'text/csv', disposition: 'inline'
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params[:address].permit(
        :business_name,
        :address_1,
        :address_2,
        :zip_code,
        :city,
        :country,
        :phone,
        :latitude,
        :longitude,
        :date_start,
        :date_end,
        :status
    )
  end
end
