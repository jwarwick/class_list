defmodule ClassList.Repo do
  use Ecto.Repo, otp_app: :class_list
  @dialyzer {:nowarn_function, rollback: 1}
end
