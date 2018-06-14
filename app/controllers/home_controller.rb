class HomeController < ApplicationController
    
    def index
       @msg = "나의 첫 레일즈 앱에 오신것을 환영합니다" 
    end
    
    def lotto
       @lotto = (1..45).to_a.sample(6).sort!
    end
    
    def lunch
       @menu = {"순남시래기" => "https://t1.daumcdn.net/cfile/tistory/2110194F561E2E7B30", "20층" => "https://t1.daumcdn.net/cfile/tistory/27234D3F58F61AF006" }
       @lunch = @menu.keys.sample
    end
end
