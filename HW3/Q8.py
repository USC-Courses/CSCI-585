import math
import simplekml
import numpy as np
import matplotlib.pyplot as plt

R = 8
r = 1
a = 4
scale = 0.01
center = (-118.28926, 34.02120)
kml_path = './HW3_Q8.kml'


def spirograph_curve(t):
    x = ((R+r) * math.cos((r/R)*t) - a * math.cos((1 + r/R) * t)) * scale
    y = ((R+r) * math.sin((r/R)*t) - a * math.sin((1 + r/R) * t)) * scale
    return (x + center[0], y + center[1])


def generate_kml(points):
    kml = simplekml.Kml()
    curve = kml.newlinestring()
    curve.name = "spirograph_curve"
    curve.description = "Spirograph Curve"
    curve.coords = points
    kml.save(kml_path)


if __name__ == "__main__":
    timeline = np.arange(0, 16 * math.pi, 0.01)
    points = [spirograph_curve(t) for t in timeline]
    generate_kml(points)
    plt.plot(list(zip(*points))[0], list(zip(*points))[1])
    plt.show()
