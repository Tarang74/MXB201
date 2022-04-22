function F = root3d(x)
    F(1) = [
            cos(x5) * cos(x6), cos(x6) * sin(x4) * sin(x5) - cos(x4) * sin(x6), sin(x4) * sin(x6) + cos(x4) * cos(x6) * sin(x5);
            cos(x5) * sin(x6), cos(x4) * cos(x6) + sin(x4) * sin(x5) * sin(x6), cos(x4) * sin(x5) * sin(x6) - cos(x6) * sin(x4);
            -sin(x5), cos(x5) * sin(x4), cos(x4) * cos(x5)
        ] * V(:, 1)
    F(2) = [
        cos(x5) * cos(x6), cos(x6) * sin(x4) * sin(x5) - cos(x4) * sin(x6), sin(x4) * sin(x6) + cos(x4) * cos(x6) * sin(x5);
        cos(x5) * sin(x6), cos(x4) * cos(x6) + sin(x4) * sin(x5) * sin(x6), cos(x4) * sin(x5) * sin(x6) - cos(x6) * sin(x4);
        -sin(x5), cos(x5) * sin(x4), cos(x4) * cos(x5)
        ] * V(:, 2)
    F(3) = [
        cos(x5) * cos(x6), cos(x6) * sin(x4) * sin(x5) - cos(x4) * sin(x6), sin(x4) * sin(x6) + cos(x4) * cos(x6) * sin(x5);
        cos(x5) * sin(x6), cos(x4) * cos(x6) + sin(x4) * sin(x5) * sin(x6), cos(x4) * sin(x5) * sin(x6) - cos(x6) * sin(x4);
        -sin(x5), cos(x5) * sin(x4), cos(x4) * cos(x5)
        ] * V(:, 3)