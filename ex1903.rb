# -*- coding: utf-8 -*-
# 蔵書管理
# PStoreでデータを管理する
require 'date'
require 'pstore'

class BookInfo
  def initialize(title, author, page, publish_date)
    @title = title
    @author = author
    @page = page
    @publish_date = publish_date
  end
  
  attr_accessor :title, :author, :page, :publish_date
  
  def to_s
    "#{@title}, #{@author}, #{@page}, #{@publish_date}"
  end
  
  def toFormattedString(sep = "\n")
    "書籍名： #{@title}#{sep}著者名： #{@author}#{sep}ページ数： #{@page}ページ#{sep}発刊日： #{@publish_date}#{sep}"
  end
end

class BookInfoManager
  def initialize(pstore_name)
    @db = PStore.new(pstore_name)
  end
  
  def addBookInfo
    book_info = BookInfo.new("", "", 0, Date.new)
    print "\n"
    print "キー："
    key = gets.chomp
    print "書籍名："
    book_info.title = gets.chomp
    print "著者名："
    book_info.author = gets.chomp
    print "ページ数："
    book_info.page = gets.chomp.to_i
    print "発行年："
    year = gets.chomp.to_i
    print "発行月："
    month = gets.chomp.to_i
    print "発行日："
    day = gets.chomp.to_i
    book_info.publish_date = Date.new(year, month, day)
    
    @db.transaction do
      @db[key] = book_info
    end
  end
  
  def listAllBookInfos
    puts "\n--------------------"
    @db.transaction(true) do
      @db.roots.each{ |key|
        puts "キー： #{key}"
        print @db[key].toFormattedString
        puts "\n--------------------"
      }
    end
  end
  
  def delBookInfo
    print "\n"
    print "キーを指定して下さい："
    key = gets.chomp
    
    @db.transaction do
      if @db.root?(key)
        print @db[key].toFormattedString
        print "\n削除しますか？(y/n)"
        yesno = gets.chomp.upcase
        if /^Y$/ =~ yesno
          @db.delete(key)
          puts "\nデータベースから削除しました"
        end
      end
    end
  end
  
  def run
    while true
      print "
1. 蔵書データの登録
2. 蔵書データの表示
3. 蔵書データの削除
9. 終了
番号を選んで下さい(1, 2, 3, 9)："

      num = gets.chomp
      case
        when '1' == num
          addBookInfo
        when '2' == num
          listAllBookInfos
        when '3' == num
          delBookInfo
        when '9' == num
          break;
        else
      end
    end
  end

end

book_info_manager = BookInfoManager.new("book_info.db")

book_info_manager.run