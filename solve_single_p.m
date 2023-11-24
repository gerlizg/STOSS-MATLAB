function [x, y] = solve_single_p (vao)

    x = (vao(2) * vao(1))/(1+vao(2));
    y = vao(1) - x;
    