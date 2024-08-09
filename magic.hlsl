// ==========================================================
//  Copyright (c) 2024 Ando Du. All rights reserved.
//  License: MIT
//  Authors: Ando Du 
// ==========================================================
struct SPD
{
    float r[31];
    float lum;
};

struct MIX
{
    SPD spd[20];
    float con[20];
    int ncol;
};


float num_int(SPD f, int a = 0, int b = 30)
{
    float t = f.r[a] + f.r[b];
    int x = a + 1;
    while (x < b)
    {
        t+= 4 * f.r[x];
        x++;
        if (x < b)
        {
            t += 2 * f.r[x];
        }
        x++;
    }
    return (t / 3);
}

float3 spd2xyz(SPD spd, SPD lum_spd, SPD x_spd, SPD y_spd, SPD z_spd)
{
    
    SPD spdn;
    SPD spd0;
    SPD spdx, spdy, spdz;
    for (int i = 0; i < 31; i++)
    {
        spdn.r[i] = lum_spd.r[i] * y_spd.r[i];
        spd0.r[i] = lum_spd.r[i] * spd.r[i];
        spdx.r[i] = spd0.r[i] * x_spd.r[i];
        spdy.r[i] = spd0.r[i] * y_spd.r[i];
        spdz.r[i] = spd0.r[i] * z_spd.r[i];
    }
    float k = 1.0f;
    float n = num_int(spdn);
    float x = k / n * num_int(spdx);
    float y = k / n * num_int(spdy);
    float z = k / n * num_int(spdz);
    
    return float3(x, y, z);
}

float c2sc(float c)
{
    if (abs(c) < 0.0031308)
        return 12.92 * c;
    return 1.055 * pow(c, 0.41666) - 0.055;
}

float3 xyz2rgb(float3 xyz)
{
    float3x3 m =
    {
        3.1338561, -1.6168667, -0.4906146,
        -0.9787684, 1.9161415, 0.0334540,
        0.0719453, -0.2289914, 1.4052427
    };
    float3 rgb = mul(m, xyz);
    if (rgb.x < 0)
        rgb.x = 0;
    if (rgb.y < 0)
        rgb.y = 0;
    if (rgb.z < 0)
        rgb.z = 0;
    if (rgb.x > 1)
        rgb.x = 1;
    if (rgb.y > 1)
        rgb.y = 1;
    if (rgb.z > 1)
        rgb.z = 1;
    return rgb;
}

float3 rgb2srgb(float3 rgb)
{
    float3 srgb;
    srgb.x = c2sc(rgb.x);
    srgb.y = c2sc(rgb.y);
    srgb.z = c2sc(rgb.z);
    return srgb;
}

float rm2rt(float rm, float k1, float k2)
{
    float rt = (rm - k1) / (1 - k1 - k2 * (1 - rm));
    if (rt < 0.001)
        rt = 0.001;
    if (rt > 0.999)
        rt = 0.999;
    return rt;
}

float rt2rm(float rt, float k1, float k2)
{
    float rm = (k1 + rt * (1 - k1 - k2)) / (1 - rt * k2);
    if (rm < 0.001)
        rm = 0.001;
    if (rm > 0.999)
        rm = 0.999;
    return rm;
}

float magic(float con)
{
    return pow(con, 2.71f);
}

SPD col_mix(MIX mix)
{
    SPD mixed;
    for (int i = 0; i < 31; i++)
    {
        float con_tot = 0.0f;
        float r_tot = 0.0f;
        for (int j = 0; j < mix.ncol; j++)
        {
            con_tot += magic(mix.con[j]);
            r_tot += 1.0f / rm2rt(mix.spd[j].r[i], 0.032, 0.4) * magic(mix.con[j]);// rm2rt second variable 0.032 recommended 
        }
        mixed.r[i] = rt2rm(con_tot / r_tot, 0.023, 0.4); // rt2rm second variable 0.02 - 0.025 recommended
    }
    return mixed;
}

SPD lin_mix(MIX mix)
{
    SPD mixed;
    for (int i = 0; i < 31; i++)
    {
        float con_tot = 0.0f;
        float r_tot = 0.0f;
        for (int j = 0; j < mix.ncol; j++)
        {
            con_tot += magic(mix.con[j]);
            r_tot += mix.spd[j].r[i] * magic(mix.con[j]);
        }
        mixed.r[i] = r_tot / con_tot;
    }
    return mixed;
}

