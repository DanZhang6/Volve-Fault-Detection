function norm=buildingnews(X_normal,len,no_of_norm10,no_of_norm12,no_of_norm14,no_of_norm16,no_of_norm18,no_of_norm20,no_of_norm23,no_of_norm25,no_of_norm28,no_of_norm30,no_of_norm40,no_of_norm50)
%注意，no_of_norm值越高，曲线越接近平均曲线,histogram往往波峰越窄,训练出的算法容忍度越低，故应当多次取不同的值
    norm=zeros(280,1);
    for n=1:12
        switch n
            case 1
                times=no_of_norm10;
                no_of_norm=10;
            case 2
                times=no_of_norm12;
                no_of_norm=12;
            case 3
                times=no_of_norm14;
                no_of_norm=14;
            case 4
                times=no_of_norm16;
                no_of_norm=16;
            case 5
                times=no_of_norm18;
                no_of_norm=18;
            case 6
                times=no_of_norm20;
                no_of_norm=20;
            case 7
                times=no_of_norm23;
                no_of_norm=23;
            case 8
                times=no_of_norm25;
                no_of_norm=25;
            case 9
                times=no_of_norm28;
                no_of_norm=28;
            case 10
                times=no_of_norm30;
                no_of_norm=30;
            case 11
                times=no_of_norm40;
                no_of_norm=40;
            case 12
                times=no_of_norm50;
                no_of_norm=50;
        end
        for m=1:times
            R=ceil(rand(1,len).*len);
            for i=1:(643-no_of_norm)
            S=sum(X_normal(1:280,R(1,i:i+no_of_norm)),2)./no_of_norm;
            norm=[norm,S];
            end
            fprintf('m= d%',m)
        end
        fprintf('n= d%',n)
    end
end