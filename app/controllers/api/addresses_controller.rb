class Api::AddressesController < Api::BaseController
  # before_action :authenticate, except: :create
  skip_before_action :authenticate_request, only: %i[login register]
  before_action :set_address, except: %i[create index]

  def create
    @institution = Institution.find(params[:institution_id])
    @address = @institution.addresses.new(address_params)
    if @address.save
      @address
    else
      p @address.errors
      return not_found
    end
  end

  def show
    respond_with @address
  end

  def update
    if @address.update(address_params)
      respond_with @address
    else
      return not_found
    end
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
