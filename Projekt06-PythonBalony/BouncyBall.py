import turtle
import random

wn = turtle.Screen()
wn.setup(width=800,height=600)
wn.bgcolor("black")
wn.title("BouncingBall By @Me")
wn.tracer(0)

colors = ["red","white","orange","pink","yellow","grey","purple"]
shapes = ["square", "triangle", "circle"]

balls = []

for _ in range(25):
    balls.append(turtle.Turtle())

for ball in balls:
    ball.shape(random.choice(shapes))
    ball.color(random.choice(colors))
    ball.shapesize(stretch_wid=1,stretch_len=1)
    ball.penup()
    ball.speed(0)
    x = random.randint(-290, 290)
    y = random.randint(200, 400)
    ball.goto(x,y)
    ball.dy = 0
    ball.dx = random.randint(-1, 1)
    ball.da = 0.3

gravity = 0.01



while True:
    wn.update()

    for ball in balls:
        ball.rt(ball.da)
        ball.dy -= gravity
        ball.sety(ball.ycor() + ball.dy)

        ball.setx(ball.xcor() + ball.dx)

        if ball.ycor() < -270:
            ball.dy *= -1

        if ball.xcor() > 370:
            ball.dx *= -1

        if ball.xcor() < -370:
            ball.dx *= -1