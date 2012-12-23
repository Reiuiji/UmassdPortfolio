function M = invest(S,r,N)
M = S*(r/1200)/((1 + r/1200)^(12*N) - 1);