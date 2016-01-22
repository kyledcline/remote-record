class Installment < RemoteRecord::Base
  source :folio

  convert :amount,          :to_f
  convert :received_amount, :to_f
  convert :current_due,     :to_f
  convert :due_date,        :to_date

  def past_due?
    past_due > 0
  end
end
