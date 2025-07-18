module IndividualsHelper
  def inventories_count(individual)
    # individual.inventories.count # N+1問題を引き起こす可能性あり
    individual.inventories.size   # 既に読み込まれていればその数を、なければDBに問い合わせる
                                  # N+1問題を避けるなら、コントローラーでincludesするか、counter_cacheを使う
  end
end