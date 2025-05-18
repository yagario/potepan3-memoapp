require "csv" 

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

# ユーザーに正しい値を入力させるためのループ処理
memo_type = nil
until [1, 2].include?(memo_type)
  puts "1 または 2 を入力してください。"
  memo_type = gets.to_i
end

if memo_type == 1
  puts "新規メモのファイル名を入力してください（拡張子なし）:"
  file_name = gets.chomp + ".csv"

  puts "メモの内容を入力してください（終了するには Ctrl + D を押してください）:"
  memo_content = STDIN.read

  CSV.open(file_name, "w") do |csv|
    csv << [memo_content]
  end

  puts "メモを作成しました！"

elsif memo_type == 2
  puts "編集するメモのファイル名を入力してください（拡張子なし）:"
  file_name = gets.chomp + ".csv"

  if File.exist?(file_name)
    puts "現在のメモの内容:"
    CSV.foreach(file_name) { |row| puts row }

    puts "追加するメモの内容を入力してください（終了するには Ctrl + D を押してください）:"
    new_content = STDIN.read

    CSV.open(file_name, "a") do |csv|
      csv << [new_content]
    end

    puts "メモを更新しました！"
  else
    puts "指定されたファイルが見つかりません。"
  end
end