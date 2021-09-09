class Cook < ApplicationRecord
   after_create :future_cook_send_admin


   belongs_to :user

   has_many :dishes
   
   has_one_attached :avatar

   validates :siren, presence: true, uniqueness: true, length: { is: 9 } #, format: {with: /^(RCS )?([0-9]{3} ){2}[0-9]{3}$|^([0-9]{3} ){3}[0-9]{4}$/, message: "Numéro de SIREN invalide"}
   validates :business_name, presence: true
   validates :legal_status, presence: true
   validates :headquarter, presence: true
   validates :vat_number, presence: true, length: { is: 11 } #, format: {with: /(?xi)^(?[0-9A-Z]{2}[0-9]{9}$)/, message: "Numéro de TVA invalide"}
   validates :commercial_register, presence: true

   private

   def future_cook_send_admin
      AdminMailer.future_cook(self).deliver_now
   end
end