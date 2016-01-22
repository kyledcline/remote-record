class Spouse < RemoteRecord::Base
  source :rolodex

  def self.current_for_account(account)
    where(account_id: account.id).sort_by(&:created_at).last
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
