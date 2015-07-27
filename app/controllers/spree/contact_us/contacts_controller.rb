class Spree::ContactUs::ContactsController < Spree::StoreController

  helper "spree/products"
  def create
    @contact = Spree::ContactUs::Contact.new(params[:contact_us_contact])
    status = verify_google_recptcha(SECRET_KEY,params['g-recaptcha-response'])
    if @contact.save && status
      if Spree::ContactUs::Config.contact_tracking_message.present?
        flash[:contact_tracking] = Spree::ContactUs::Config.contact_tracking_message
      end
      redirect_to(spree.root_path, :notice => Spree.t('contact_us.notices.success'))
    else
      render :new
    end
  end

  def new
    @contact = Spree::ContactUs::Contact.new
    @taxonomies = Spree::Taxonomy.includes(root: :children)
  end

  private

  def accurate_title
    Spree.t(:contact_us_title)
  end

end
