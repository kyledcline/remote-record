class MaritalStatus < RemoteRecord::Base
  source :rolodex

  def self.current_for_account(account)
    find_by(account_id: account.id, ended_on: nil)
  end

  delegate :married?, :not_married?, to: :marital_status_type
  convert :marital_status_type, :inquiry
end
