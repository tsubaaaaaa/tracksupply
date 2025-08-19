class PublicIndividualsController < ApplicationController
  # ★★★ このコントローラーのアクションではログインを要求しない ★★★
  skip_before_action :authenticate_user!

  # ★★★ 独自のレイアウトファイルを使う (サイドバーなどを表示させないため) ★★★
  layout 'public' # public.html.erb というレイアウトファイルを探す

  def show
    # トークンを使って個体情報を検索。見つからなければ404エラーになる
    @individual = Individual.find_by!(token: params[:token])
  end
end
