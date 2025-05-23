module ApplicationHelper

  require "rqrcode"
  require "rqrcode_png"
  require "chunky_png"

  def qrcode(individual)
      Rails.logger.debug "qrcode method received: #{individual.inspect}" # デバッグ出力

      unless individual.is_a?(Individual)
          Rails.logger.error "❌ qrcode method received invalid object: #{individual.class}"
          return nil
      end

      # トークンが未設定の場合は生成して保存
    
      base_url = Rails.application.routes.url_helpers.root_url(host: Rails.application.routes.default_url_options[:host])
      qr_url = "#{base_url}individuals/#{individual.id}"
      
      qrcode = RQRCode::QRCode.new(qr_url)
      qrcode.as_png(
      border_modules: 0,
      size: 150).to_data_url
  end
    
end