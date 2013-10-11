class Contact
  include Id::Model

  field :type
  field :phone, key: 'telephone'
  field :fax, key: 'faxNumber'
end
