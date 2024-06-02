import turtle
#import os
import math
import random



wn = turtle.Screen()
wn.title("Ahoj")
wn.setup(width=800,height=800)
wn.bgcolor("black")
wn.tracer(0)


border = turtle.Turtle()
border.speed(0)
border.color("white")
border.penup()
border.goto(-300,-300)
border.pendown()
border.pensize(3)

pen = turtle.Turtle()
pen.speed(0)
pen.color("white")
pen.penup()
pen.hideturtle()
pen.goto(370, 320)
pen.write("Space - shoot\na - move left\nd - move right", align = "right", font = ("Bahnschrift", 15, "normal"))

for side in range(4):
    border.forward(600)
    border.left(90)
border.hideturtle()

player = turtle.Turtle()
player.color("blue")
player.shape("triangle")
player.penup()
player.speed(0)
player.goto(0,-250)
player.setheading(90)
player.speed = 0

number_of_enemies = 5

enemies = []
for i in range(number_of_enemies):
    enemies.append(turtle.Turtle())

for enemy in enemies:
    enemy.speed(0)
    enemy.color("red")
    enemy.shape("square")
    enemy.penup()
    x = random.randint(-200, 200)
    y = random.randint(-100, 250)
    enemy.goto(x,y)

enemy_speed = 0.2

bullet = turtle.Turtle()
bullet.color("yellow")
bullet.shape("triangle")
bullet.penup()
bullet.speed(0)
bullet.setheading(90)
bullet.shapesize(0.5,0.5)
bullet.hideturtle()

score = 0

score_pen = turtle.Turtle()
score_pen.speed(0)
score_pen.color("white")
score_pen.penup()
score_pen.setposition(-290, 273)
scorestring = "Score: {}".format(score)
score_pen.write(scorestring, False, align="left", font=("Bahnschrift", 14, "normal"))
score_pen.hideturtle()

bullet_speed = 1.5

bullet_state = "ready"



def left():
    player.speed = -0.5

def right():
    player.speed = 0.5

def move_player():
    x = player.xcor()
    x += player.speed
    if x < -285:
        x = -285
    if x > 285:
        x = 285
    player.setx(x)


def fire_bullet():
    global bullet_state
    if bullet_state == "ready":
        bullet_state = "fire"
        x = player.xcor()
        y = player.ycor() +10
        bullet.setposition(x,y)
        bullet.showturtle()

def isCollision(t1, t2):
    distance = math.sqrt(math.pow(t1.xcor()-t2.xcor(),2)+math.pow(t1.ycor()-t2.ycor(),2))
    if distance < 15:
        return True
    else:
        return False
wn.listen()
wn.onkeypress(left, "a")
wn.onkeypress(right, "d")
wn.onkeypress(fire_bullet, "space" )
while True:

    wn.update()

    move_player()

    for enemy in enemies:
        x = enemy.xcor()
        x += enemy_speed
        enemy.setx(x)

        if enemy.xcor() > 280:
            for e in enemies:
                y = e.ycor()
                y -= 30
                e.sety(y)
            enemy_speed *= -1

        if enemy.xcor() < -280:
            for e in enemies:
                y = e.ycor()
                y -= 30
                e.sety(y)
            enemy_speed *= -1

        if isCollision(bullet, enemy):
            bullet.hideturtle()
            bullet_state = "ready"
            bullet.setposition(0, -400)
            x = random.randint(-200, 200)
            y = random.randint(-100, 250)
            enemy.setposition(x, y)
            score += 10
            scorestring = "Score: {}".format(score)
            score_pen.clear()
            score_pen.write(scorestring, False, align="left", font=("Bahnschrift", 14, "normal"))

        if isCollision(enemy, player):
            player.hideturtle()
            enemy.hideturtle()
            break

    if bullet_state == "fire":
        y = bullet.ycor()
        y += bullet_speed
        bullet.sety(y)

    if bullet.ycor() > 275:
        bullet.hideturtle()
        bullet_state = "ready"