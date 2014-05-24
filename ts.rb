#! ruby -Ku
# -*- coding: utf-8 -*-

class Game

	def initialize
		@card = []
		@vil = []
		@dangeon = []
		@deck = []
		@hand = []
		@trash = []
		@pool = []
		@level = []
		@inv = []
		@turn = 1

		@gold = 0
		@wp = 0
		@exp = 0
		@light = 0

		@villaCount = 0 # 村で購入できる回数
	end

	def dupnum( num, obj )
		list = []
		(0..num-1).each do |idx|
			list.push obj
		end
		return list
	end

	def shuffle( list )
		num = list.length
		(0..num*10).each do |idx|
			a = rand(num)
			b = rand(num)
			old = list[a]
			list[a] = list[b]
			list[b] = old
		end
		return list
	end

	def resetHand
		@trash += @hand
		@hand = []
		(0..5).each do |idx|
			if @deck.length < 1
				@deck += @trash
				@trash = []
				@deck = shuffle( @deck )
			end
			@hand.push @deck.pop
		end
	end

	def setup

		@card[1] = {
			"name" => "たいまつ       ",
			"gold" => 2,
			"price" => 3,
			"types" => ["アイテム","明かり"],
			"light" => 1,
			"set" => "base"
		}

		@card[0] = {
			"name" => "民兵           ",
			"gold" => 0,
			"price" => 0,
			"str" => 2,
			"exp" => 3,
			"types" => ["民兵","英雄"],
			"text" => "攻撃+1",
			"set" => "base"
		}

		@card[2] = {
			"name" => "ダガー         ",
			"gold" => 1,
			"price" => 3,
			"types" => ["武器","鋭利"],
			"text" => "攻撃+1",
			"set" => "base"
		}

		@card[3] = {
			"name" => "保存食         ",
			"gold" => 2,
			"price" => 2,
			"types" => ["アイテム","食料"],
			"text" => "ダンジョン: 英雄1枚は体力 +2 を得る。",
			"set" => "base"
		}

		@card[4] = {
			"name" => "ごちそう       ",
			"gold" => 2,
			"price" => 2,
			"types" => ["アイテム","食料"],
			"text" => "ダンジョン: 英雄1枚は体力 +2 を得る。",
			"set" => "base"
		}
		@card[5] = {
			"name" => "ファイアーボール",
			"price" => "9",
			"types" => ["呪文"],
			"text" => "魔法攻撃+9",
			"light" => 1,
			"set" => "base"
		}
		@card[6] = {
			"name" => "ショートソード  ",
			"gold" => 3,
			"price" => 6,
			"weight" => 4,
			"types" => ["武器","鋭利"],
			"text" => "攻撃+4",
			"set" => "base"
		}
		@card[7] = {
			"name" => "ランタン       ",
			"gold" => 2,
			"price" => 4,
			"types" => ["アイテム","明かり"],
			"light" => 2,
			"set" => "base"
		}

		@card[8] = {
			"name" => "魔法果実       ",
			"gold" => 2,
			"price" => 4,
			"types" => ["アイテム","食料","魔法"],
			"text" => "ダンジョン: 英雄1枚は体力+3を得る。その英雄の攻撃は魔法攻撃になる。",
			"wp" => 1,
			"set" => "base"
		}
		@card[9] = {
			"name" => "フレイムソード  ",
			"gold" => 2,
			"price" => 5,
			"weight" => 5,
			"types" => ["武器","鋭利"],
			"text" => "魔法攻撃+3",
			"set" => "base"

		}
		@card[10] = {
			"name" => "町の衛兵      ",
			"price" => 3,
			"types" => ["村人"],
			"text" => "村: カードを2枚引く。村: このカードを破棄することで、追加で3枚のカードを引く。",
			"set" => "base"
		}
		@card[11] = {
			"name" => "酒場の主人    ",
			"price" => 3,
			"types" => ["村人"],
			"text" => "村: 金貨値を持つカード1枚を破棄することで、その金貨値+3を得る。村: このカードを破棄することで、2金貨を得る。",
			"set" => "base"
		}

		@card[12] = {
			"hid" => 1,
			"name" => "チャリスの探索者   ",
			"price" => 7,
			"str" => 5,
			"exp" => 2,
			"level" => 1,
			"types" => ["戦士","僧侶"],
			"text" => "ダンジョン(くり返し): 病気1枚を破棄することで、カード1枚を引く。",
			"set" => "base"

		}
		@card[13] = {
			"hid" => 2,
			"name" => "アウトランズの闘士 ",
			"price" => 8,
			"str" => 7,
			"exp" => 2,
			"level" => 1,
			"types" => ["戦士"],
			"text" => "ダンジョン: 食料1枚を破棄することで、追加攻撃+3",
			"set" => "base"
		}
		@card[14] = {
			"name" => "ドワーフの警備隊員",
			"hid" => 3,
			"price" => 6,
			"str" => 5,
			"exp" => 2,
			"level" => 1,
			"types" => ["戦士"],
			"text" => "攻撃+1 鋭利武器を装備すれば追加攻撃+3。",
			"set" => "base"
		}
		@card[15] = {
			"name" => "セルーリンの魔法使い",
			"hid" => 4,
			"price" => 8,
			"str" => 2,
			"exp" => 2,
			"level" => 1,
			"types" => ["魔術師"],
			"text" => "魔法攻撃+2 すべてのアイテムと魔法攻撃呪文は魔法攻撃+1を得る。",
			"set" => "base"
		}

		@card[16] = {
			"name" => "レギアンの僧侶     ",
			"hid" => 5,
		}
		@card[17] = {
			"name" => "ロリッグの盗賊     ",
			"hid" => 6,
		}
		@card[18] = {
			"name" => "エルフの妖術師     ",
			"hid" => 7,
		}
		@card[19] = {
			"name" => "シリアンの騎士見習い",
			"hid" => 8,
		}

		@card[20] = {
			"name" => "病気              ",
			"text" => "攻撃-1",
			"types" => ["病気"],
			"set" => "base"
		}

		@card[21] = {
			"name" => "サンダーストーン",
			"types" => ["サンダーストーン"],
			"set" => "base"
		}

		@card[22] = {
			"name" => "クラッジビースト",
			"types" => ["アビサル","モンスター"],
			"gold" => 1,
			"wp" => 2,
			"hp" => 4,
			"exp" => 1,
			"set" => "base"
		}
		@card[23] = {
			"name" => "モーティス卿",
			"types" => ["アビサル","モンスター"],
			"gold" => 1,
			"wp" => 2,
			"hp" => 4,
			"exp" => 1,
			"set" => "base"
		}
		@card[24] = {
			"name" => "スカラダック",
			"types" => ["ドラゴン","ホワイト","モンスター"],
			"gold" => 3,
			"wp" => 3,
			"hp" => 7,
			"exp" => 2,
			"text" => "戦闘: 武器1枚を破棄する。",
			"set" => "base"
		}
		@card[25] = {
			"name" => "ブリンクドッグ",
			"types" => ["エンチャンテッド","モンスター"],
			"gold" => 1,
			"wp" => 2,
			"hp" => 3,
			"exp" => 1,
			"text" => "明かり-1 明かりペナルティがあると攻撃できない。",
			"set" => "base"
		}
		@card[26] = {
			"name" => "グリックナックゴブリン",
			"types" => ["ヒューマノイド","モンスター"],
			"gold" => 1,
			"wp" => 1,
			"hp" => 4,
			"exp" => 1,
			"set" => "base"
		}
		@card[27] = {
			"name" => "グリーンブロブ",
			"types" => ["スライム","モンスター"],
			"gold" => 1,
			"wp" => 2,
			"hp" => 5,
			"exp" => 1,
			"text" => "戦闘: 食料1枚を破棄する。",
			"set" => "base"
		}
		@card[28] = {
			"name" => "前兆",
			"types" => ["アンデッド","ドゥーム","モンスター"],
			"gold" => 2,
			"wp" => 1,
			"hp" => 3,
			"exp" => 1,
			"text" => "戦闘: 呪文1枚を破棄する。",
			"set" => "base"
		}
		@card[29] = {
			"name" => "ホーント",
			"types" => ["アンデッド","スピリット","モンスター"],
			"gold" => 1,
			"wp" => 2,
			"hp" => 4,
			"exp" => 1,
			"text" => "戦闘: 英雄1枚は攻撃できない。",
			"set" => "base"
		}

		(0..15).each do |idx|
			@vil.push( dupnum( 10, @card[idx] ))
		end

		@dangeon += dupnum( 3, @card[22] )
		@dangeon += dupnum( 3, @card[23] )
		@dangeon += dupnum( 3, @card[24] )
		@dangeon += dupnum( 3, @card[25] )
		@dangeon += dupnum( 3, @card[26] )
		@dangeon += dupnum( 3, @card[27] )
		@dangeon += dupnum( 3, @card[28] )
		@dangeon += dupnum( 3, @card[29] )

		@dangeon = shuffle( @dangeon )
		@dangeon.insert( -(1+rand(10)), @card[21])

=begin
		dangeon.each do |y|
			p y["name"]
		end
=end

		@deck += dupnum( 6, @card[0] )
		@deck += dupnum( 2, @card[1] )
		@deck += dupnum( 2, @card[2] )
		@deck += dupnum( 2, @card[3] )

		@deck = shuffle( @deck )

	end

	def showBoard

		@gold = 0
		@hand.each do |h|
			@gold += h["gold"] unless h["gold"] == nil
		end

		@light = 0
			@hand.each do |h|
			@light += h["light"] unless h["light"] == nil
		end

		print "-----------------------------------------------\n"
		print "turn: ", @turn, "\n"

		(0..2).each do |i|
			break if @level[i] == nil
			x = @level[i]
			print "Lv", (i+1).to_s, ": hp[", x["hp"].to_s.rjust(2), "] wp[",  x["wp"].to_s + "] "
			print x["name"].ljust(30), "\t", (x["text"] != nil ? '[' + x["text"] + ']' : ''), "\n"
		end

		print "\n"
		sep = ' '

		(0..3).each do |i|
			s = []
			(0..3).each do |j|
				k = i*4+j
				v = @vil[k]
				next if v == nil
				next if v.length == 0
				if @gold >= v[0]["price"].to_i then
					sep = '*'
				else
					sep = ' '
				end
				s.push( "v" + k.to_s.ljust(2) + sep + '[' + v[0]["price"].to_s.rjust(2) + ']:' + v[0]["name"].ljust(20) )
			end
			print s.join("\t"), "\n"
		end

		print "\n"

#		print @dangeon[0]["name"], "\n\n"

		s = []
		idx = 0
		@hand.each do |h|
			s.push "h#{idx}: " + h["name"].ljust(20)
			idx += 1
		end
		print s.join("\t"), "\n\n"

		print "金貨: #{@gold}, 明かり: #{@light}\n経験値: #{@exp}, 勝利ポイント: #{@wp}\n\n"

		@turn += 1

	end

	def nextLevel

		if @dangeon.length == 0
			print "Finish"
			exit 1
		end

		if @level.length == 3
			@inv.push @level.shift
		end

		@level.push @dangeon.shift
	end

	# 村: カードの効果を適用
	def hookVilla
	end

	def buyInVilla
		@villaCount -= 1
		print "購入するカードを選択:v[1-15] "
	end

	def run
		while true
			resetHand
			nextLevel
			showBoard

			while true
				print "1:村\t2:ダンジョン\t3:休息 --> "
				input = gets.chop!

				if input =~ /v(\d+)/
					k = $1.to_i
					if k < 16
						p @vil[k][0]
					end
				elsif input =~ /l(\d+)/
					k = $1.to_i - 1
					if k < @level.length
						p @level[k]
					end
				elsif input =~ /h(\d+)/
					k = $1.to_i - 1
					if k < @hand.length
						p @hand[k]
					end
				end

				# 村
				if input == "1"
					@villaCount = 1
					hookVilla # 村: カードの効果

					while @villaCount > 0
						buyInVilla
					end

				elsif input == "2" # ダンジョン
				elsif input == "3" # 休息
					f = false
					@hand.each do |h|
						h["types"].each do |t|
							if t == "病気"
								f = true
							end
						end
					end
					if f == true
						print "病気カードを1枚破棄しました。\n" # 病気カードを選べるようにするべきか
						break
					else
						print "病気カードはありません。\n"
						next
					end
				elsif input == "q" 
					break
				end
				break if input == "1" || input == "2" || input == "3" || input == "q"
			end

			break if input == "q"

		end
	end
end

game = Game.new
game.setup
game.run







