require 'uri'
module YolCommon
 
  MOBILE_REGEX = Regexp.new('palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile|zune')

  class Validator

    # 手机
    def self.is_mobile_agent?(agent)
      return true if agent.to_s.downcase =~ MOBILE_REGEX
      false
    end

    # 邮箱
    def self.email?(email)
      return false if email.length <= 3 || email.length >= 255
      # email如包含\xBF则会报错：inval​id by​te se​quenc​e in ​UTF-8，在ruby2.1可以用scrub函数去掉错误编码的字符
      return true if email.to_s =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i rescue nil
      false
    end

    # 手机
    def self.mobile?(mobile)
      return true if mobile.to_s =~ /^(13|14|15|16|17|18|19)\d{9}$/
      false
    end

    # 密码
    def self.password?(pwd)
      return true if pwd.length >=4 && pwd.length <= 40
      false
    end

    # 静态文件名
    def self.asset_file_name?(file_name)
      ext = File.extname(file_name)
      file_name = File.basename(file_name, ext) unless ext.empty?
      return true if file_name =~ /^[\w\.\-\_]+$/
      false
    end

    # 静态文件后缀
    def self.asset_file_ext?(file_name)
      name = file_name.to_s.downcase
      ext = File.extname(name)
      return false if ext.empty?
      %w{.eot .woff .woff2 .ttf .svg .js .css .htc .ico .json .otf}.include?(ext)
    end

    # 图片文件名字
    def self.image_asset_file_name?(file_name)
      ext = File.extname(file_name)
      file_name = File.basename(file_name, ext) unless ext.empty?
      return true if file_name =~ /^[\w\-\_]+$/
      false
    end

    # url
    def self.url?(url)
      # return true if url.to_s =~ /https?:\/\/[\S]+/
      return true if url.to_s.scan(URI.regexp).length > 0
      false
    end

    # 域名
    def self.domain_name?(name)
      return false if name.length < 1 || name.length > 63
      return true if name.to_s =~ /^[a-z0-9-]+$/
      false
    end

    # 图片类型
    def self.image?(file_name)
      name = file_name.to_s.downcase
      ext = File.extname(name)
      return false if ext.empty?
      %w{.jpg .jpeg .gif .png .bmp .webp .ico}.include?(ext)
    end

    # icon
    def self.icon?(file_name)
      name = file_name.to_s.downcase
      ext = File.extname(name)
      return false if ext.empty?
      %w{.ico}.include?(ext)
    end

    # json
    def self.json?(file_name)
      name = file_name.to_s.downcase
      ext = File.extname(name)
      return false if ext.empty?
      ['.json'].include?(ext)
    end

    # 日期
    def self.date?(date)
      begin
        Date.parse(date)
        return true
      rescue
        return false
      end
    end

    # 整数
    def self.integer?(integer)
      begin
        Integer(integer)
        return true
      rescue
        return false
      end
    end

    # float
    def self.float?(float)
      begin
        Float(float)
        return true
      rescue
        return false
      end
    end

    # 验证身份证号码
    def self.indentity_card?(card)
      arr_int = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
      arr_ch = ['1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2']

      case card.size
      when 15
        chars = card.chars.to_a
        cardtemp_15 = 0
        chars.insert(6,'1','9')
        17.times do |i|
          cardtemp_15 += (chars[i].to_i * arr_int[i])
        end
        chars << arr_ch[cardtemp_15 % 11]
      when 18
        chars = card.chars.to_a
      else
        return false
      end

      cardtemp = 0
      17.times do |i|
        cardtemp += chars[i].to_i * arr_int[i]
      end
      arr_ch[cardtemp % 11].eql?(chars.last)
    end

    # 银行卡
    def self.bank_card?(card)
      return true if card.to_s =~ /^\d{9,20}$/
      return false
    end

    # 方法说明
    def self.under_size?(size_in_byte, limit_mb)
      size_in_byte <= limit_mb * 1024 * 1024
    end

    # 方法说明
    def self.price?(str)
      return true if str.to_s =~ /^[0-9]+([.]{1}[0-9]{1,2})?$/
      false
    end

    # 方法说明
    def self.folder_name?(str)
      return true if str.to_s =~ /^[^\\\/:*?"<>|]{1,}$/
      false
    end

    # 方法说明
    #
    # @param 参数说明
    # @return [返回数据类型] 返回说明
    def self.positive_integer?(str)
      return true if str.to_s =~ /^(0|[1-9]\d*)$/
      false
    end

    # 方法说明
    def self.max_length?(target, length = 255)
      target.to_s.length > length
    end

    # 方法说明
    def self.min_length?(target, length = 10)
      target.to_s.length < length
    end

  end
end
