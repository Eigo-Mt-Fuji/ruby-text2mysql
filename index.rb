#!/usr/local/bin/ruby

column_definitions = { 
  :race_key => [ 0, 8 ], 
  :race_date => [ 8, 8 ],
  :hassou_jikan => [ 16, 4 ],
  :race_condition => [ 20, 16 ],
  :race_name => [ 36, 50 ],
  :count => [ 86, 8 ],
  :tousuu => [ 94, 2 ],
  :course => [ 96, 1 ],
  :kaisai_kubun => [ 97, 1 ],
  :race_name_short => [ 98, 8 ],
  :race_name_9 => [ 106, 18 ],
  :data_kubun => [ 124, 1 ],
  :shokin_1 => [ 125, 5 ],
  :shokin_2 => [ 130, 5 ],
  :shokin_3 => [ 135, 5 ],
  :shokin_4 => [ 140, 5 ],
  :shokin_5 => [ 145, 5 ],
  :sannyu_shokin_1 => [ 150, 5 ],
  :sannyu_shokin_2 => [ 155, 5 ],
  :baken_flag => [ 160, 16 ]
}

# read data , conversion
File.open("./original/data.txt", "r", :encoding => "SJIS") do |fin| 

  File.open("./datas/bac.csv", "w") do |fout| 

    fin.each_line do |original|
      column_values = column_definitions.map{|column, range| 
        "#{original.byteslice(range[0], range[1]).encode("UTF-8")}"
      }
      fout.puts column_values.join(",")
    end
  end
end

# print load data command (TODO: execute by mysql-cli in terminal directly, or fix this program)
column_names = column_definitions.map{|column, range| 
  "#{column}"
}
column_names_str = column_names.join(",")
puts "LOAD DATA LOCAL INFILE './datas/bac.csv' INTO TABLE bac FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' (#{column_names_str});"

