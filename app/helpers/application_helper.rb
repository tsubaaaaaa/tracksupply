module ApplicationHelper

  require "rqrcode"
  require "rqrcode_png"
  require "chunky_png"

  def display_date(date, placeholder = "未登録")
    date.present? ? date.strftime("%Y-%m-%d") : placeholder
  end

  def qrcode(individual)
    # individual とその token が存在することを確認
    return nil unless individual&.token

    # public_individual_url ヘルパーを使って、トークン付きのURLを生成
    # host の設定が config/environments/development.rb などでされていることが前提
    qr_url = public_individual_url(token: individual.token)

    qrcode = RQRCode::QRCode.new(qr_url)
    qrcode.as_png(
      border_modules: 0,
      size: 300
    ).to_data_url
  end
    
end