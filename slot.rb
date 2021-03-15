def slot_start()
    puts("コイン何枚入れますか")
    puts("1(10コイン) 2(30コイン) 3(50コイン) 4(やめとく)")
    bet = gets.chomp.to_i
    
    if bet == 1
        bet_coin = 10
    elsif bet == 2
        bet_coin = 30
    elsif bet == 3
        bet_coin = 50
    elsif bet == 4
        puts("やーめよ")
        exit
    end

    return bet, bet_coin
end

def slot_reel()
    num1 = Random.rand(1..9)
    num2 = Random.rand(1..9)
    num3 = Random.rand(1..9)
    return num1, num2, num3
end

def per_slot(place, number, coin, bet_coin,  point)
    puts("！！大当たり！！")
    puts("#{place}に#{number}が揃いました")
    coin += bet_coin * 3
    point += bet_coin * 5
    puts("#{bet_coin * 3}枚のコインを獲得！！")
    puts("#{bet_coin * 5 }ポイント獲得！！")
    per = true
    return coin, point, per
end

coin = 100
point = 0
per = false
game_again = 1
puts("残りコイン枚数#{coin}")
puts("ポイント#{point}")

while game_again == 1
    bet_coin = 0
    
    bet, bet_coin = slot_start()

    while bet ==0 || bet >= 5 || coin < bet_coin
        if bet == 0|| bet >= 5
            puts("1-4で選んでください")
        else
            puts("現在#{coin}枚のコインを所持しています")
            puts("coinが足りません")
        end
        bet, bet_coin = slot_start()
    end
    
    coin -= bet_coin
    puts("--------------")
    puts("エンターを3回押してください")

    slot_top = [0, 0, 0]
    slot_center = [0, 0, 0]
    slot_bottom = [0, 0, 0]

    for i in 1..3 do
        slot_stop = gets.chomp.to_i
        slot_top[i-1], slot_center[i-1], slot_bottom[i-1] = slot_reel()
        if i == 1
            puts("|#{slot_top[0]}| | |")
            puts("|#{slot_center[0]}| | |")
            puts("|#{slot_bottom[0]}| | |")
        elsif i == 2
            puts("|#{slot_top[0]}|#{slot_top[1]}| |")
            puts("|#{slot_center[0]}|#{slot_center[1]}| |")
            puts("|#{slot_bottom[0]}|#{slot_bottom[1]}| |")
        elsif i == 3
            puts("|#{slot_top[0]}|#{slot_top[1]}|#{slot_top[2]}|")
            puts("|#{slot_center[0]}|#{slot_center[1]}|#{slot_center[2]}|")
            puts("|#{slot_bottom[0]}|#{slot_bottom[1]}|#{slot_bottom[2]}|")
        end
        puts("--------------")
    end


    if [slot_top[0], slot_top[1], slot_top[2]].uniq.count == 1
        coin, point, per = per_slot("上段", slot_top[0], coin, bet_coin, point)
    end
    if [slot_center[0], slot_center[1], slot_center[2]].uniq.count == 1
        coin, point, per = per_slot("真ん中", slot_center[0], coin, bet_coin, point)
    end
    if [slot_bottom[0], slot_bottom[1], slot_bottom[2]].uniq.count == 1
        coin, point, per = per_slot("下段", slot_bottom[0], coin, bet_coin, point)
    end
    if per == false
        puts("残念、ハズレ")
        if coin < 10
            puts("現在のコインは#{coin}枚です")
            puts("coinがなくなりました。")
            puts("また遊んでくださいね")
            exit
        end
    end

    puts("残りコイン枚数#{coin}")
    puts("ポイント#{point}")
    puts("--------------")
    puts("続けて遊びますか？")
    puts("1(Yes) 2(No)")
    game_again = gets.chomp.to_i
    if game_again != 1
        puts("ご利用ありがとうございました。")
        puts("また遊んでくださいね")
    end
end