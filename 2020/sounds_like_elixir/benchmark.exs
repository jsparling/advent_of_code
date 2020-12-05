Benchee.run(%{
  "orig"      => fn -> Dec1.perform_step_2_old end,
  "optimized" => fn -> Dec1.perform_step_2 end
})
