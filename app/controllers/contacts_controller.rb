class ContactsController < ApplicationController
  before_filter :find_model

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      send_email
      flash[:success] = 'Message sent.'
      redirect_to new_contact_path
    else
      flash[:danger] = 'Error occurred, message has not been sent.'
      redirect_to new_contact_path
    end
  end


  private
  def find_model
    @model = Contacts.find(params[:id]) if params[:id]
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :comments)
  end

  def send_email
    name = params[:contact][:name]
    email = params[:contact][:email]
    body = params[:contact][:comments]
    ContactMailer.contact_email(name, email, body).deliver
  end
end