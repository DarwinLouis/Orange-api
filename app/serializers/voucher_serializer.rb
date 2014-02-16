class VoucherSerializer < ActiveModel::Serializer
  attributes :id, :claim_id, :claim_code, :item_id , :created_at, :updated_at, :status
end
