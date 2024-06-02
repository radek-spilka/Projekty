import turtle
import math
import random

wn = turtle.Screen()

wn.bgcolor("black")
wn.title("<-- I think its something like feather")
         #sirka     #vyska
wn.setup(width=800, height=600)
wn.tracer(0)

player_1_healthbox = turtle.Turtle()
player_1_healthbox.color("red")
player_1_healthbox.shape("square")
player_1_healthbox.penup()
x = -300
y = random.randint(150, 200)
player_1_healthbox.goto(x, y)

player_2_healthbox = turtle.Turtle()
player_2_healthbox.color("red")
player_2_healthbox.shape("square")
player_2_healthbox.penup()
x = 300
y = random.randint(-200, -150)
player_2_healthbox.goto(x, y)

player_1_spawn_wall = turtle.Turtle()
player_1_spawn_wall.color("white")
player_1_spawn_wall.shape("square")
player_1_spawn_wall.shapesize(3,0.5)
player_1_spawn_wall.penup()
player_1_spawn_wall.goto(-250,-200)


player_2_spawn_wall = turtle.Turtle()
player_2_spawn_wall.color("white")
player_2_spawn_wall.shape("square")
player_2_spawn_wall.shapesize(3,0.5)
player_2_spawn_wall.penup()
player_2_spawn_wall.goto(250,200)

middle_player_wall = turtle.Turtle()
middle_player_wall.color("white")
middle_player_wall.shape("square")
middle_player_wall.shapesize(2,2)
middle_player_wall.penup()
middle_player_wall.goto(0,0)


player_1 = turtle.Turtle()
player_1.speed(0)
player_1.shape("square")
player_1.shapesize(stretch_len=1, stretch_wid=1)
player_1.color("white")
player_1.penup()
player_1.goto(-300, -200)


player_2 = turtle.Turtle()

player_2.speed(0)
player_2.shape("square")
player_2.shapesize(stretch_len=1, stretch_wid=1)
player_2.setheading(180)
player_2.color("white")
player_2.penup()
player_2.goto(300, 200)

bullet_player_1 = turtle.Turtle()

bullet_player_1.speed(0)
bullet_player_1.shape("square")
bullet_player_1.shapesize(stretch_len=0.5,stretch_wid=0.3)
bullet_player_1.color("yellow")
bullet_player_1.penup()
bullet_player_1.goto(0,0)
bullet_player_1.hideturtle()

bullet_player_1_state = "ready1"
bullet_player_2_state = "ready2"

bullet_player_2 = turtle.Turtle()

bullet_player_2.speed(0)
bullet_player_2.shape("square")
bullet_player_2.shapesize(stretch_len=0.5,stretch_wid=0.3)
bullet_player_2.color("yellow")
bullet_player_2.penup()
bullet_player_2.goto(0,0)
bullet_player_2.hideturtle()

bullet_speed = 1.4

player_1_health = 3
player_2_health = 3

pen = turtle.Turtle()
pen.speed(0)
pen.color("white")
pen.penup()
pen.hideturtle()
pen.goto(0, 260)
pen.write("Player 1: Health 3    \t\t    Player 2: Health 3", align = "center", font = ("Bahnschrift", 24, "normal"))

def fire_shot_player_1():
    global bullet_player_1_state
    if bullet_player_1_state == "ready1":
        bullet_player_1_state = "fire1"
        x = player_1.xcor() +10
        y = player_1.ycor()
        bullet_player_1.setposition(x,y)
        bullet_player_1.showturtle()

def fire_shot_player_2():
    global bullet_player_2_state
    if bullet_player_2_state == "ready2":
        bullet_player_2_state = "fire2"
        x = player_2.xcor() -10
        y = player_2.ycor()
        bullet_player_2.setposition(x,y)
        bullet_player_2.showturtle()


def player_1_up():
    y = player_1.ycor()
    y += 20
    player_1.sety(y)

def player_1_down():
    y = player_1.ycor()
    y -= 20
    player_1.sety(y)

def player_2_up():
    y = player_2.ycor()
    y += 20
    player_2.sety(y)

def player_2_down():
    y = player_2.ycor()
    y -= 20
    player_2.sety(y)

def isCollision(t1, t2):
    distance = math.sqrt(math.pow(t1.xcor()-t2.xcor(),2)+math.pow(t1.ycor()-t2.ycor(),2))
    if distance < 20:
        return True
    else:
        return False

def isCollisionWalls(t1, t2):
    distance2 = math.sqrt(math.pow(t1.xcor()-t2.xcor(),2)+math.pow(t1.ycor()-t2.ycor(),2))
    if distance2 < 21:
        return True
    else:
        return False

def isCollisionMiddleWall(t1, t2):
    distance2 = math.sqrt(math.pow(t1.xcor()-t2.xcor(),2)+math.pow(t1.ycor()-t2.ycor(),2))
    if distance2 < 25:
        return True
    else:
        return False

def isCollisionHealthbox(t1, t2):
    distance2 = math.sqrt(math.pow(t1.xcor()-t2.xcor(),2)+math.pow(t1.ycor()-t2.ycor(),2))
    if distance2 < 12:
        return True
    else:
        return False

wn.listen()
wn.onkeypress(player_1_up, "w")
wn.onkeypress(player_1_down, "s")
wn.onkeypress(player_2_up, "Up")
wn.onkeypress(player_2_down, "Down")
wn.onkeypress(fire_shot_player_1, "space")
wn.onkeypress(fire_shot_player_2, "0")

while True:
    wn.update()

    if player_1.ycor() > 270:
        player_1.setposition(-300, 260)

    if player_1.ycor() < -270:
        player_1.setposition(-300, -260)

    if player_2.ycor() > 270:
        player_2.setposition(300, 260)

    if player_2.ycor() < -270:
        player_2.setposition(300, -260)

    if bullet_player_1_state == "fire1":
        x = bullet_player_1.xcor()
        x += bullet_speed
        bullet_player_1.setx(x)

    if bullet_player_1.xcor() > 400:
        bullet_player_1.hideturtle()
        bullet_player_1_state = "ready1"

    if bullet_player_2_state == "fire2":
        x = bullet_player_2.xcor()
        x -= bullet_speed
        bullet_player_2.setx(x)

    if bullet_player_2.xcor() < -400:
        bullet_player_2.hideturtle()
        bullet_player_2_state = "ready2"

    if isCollision(bullet_player_1,player_2):
        bullet_player_1.hideturtle()
        bullet_player_1_state = "ready1"
        bullet_player_1.setposition(0, -400)
        player_2.setposition(300,200)
        pen.clear()
        player_2_health -= 1
        pen.write("Player 1: Health {}    \t\t    Player 2: Health {}".format(player_1_health, player_2_health), align="center", font=("Bahnschrift", 24, "normal"))

    if isCollision(bullet_player_2, player_1):
        bullet_player_2.hideturtle()
        bullet_player_2_state = "ready2"
        bullet_player_2.setposition(0,400)
        player_1.setposition(-300, -200)
        pen.clear()
        player_1_health -= 1
        pen.write("Player 1: Health {}    \t\t    Player 2: Health {}".format(player_1_health, player_2_health), align="center", font=("Bahnschrift", 24, "normal"))

    if isCollisionWalls(player_1_spawn_wall, bullet_player_2):
        bullet_player_2.hideturtle()
        bullet_player_2_state = "ready2"
        bullet_player_2.setposition(0, 400)
        player_1_spawn_wall.setposition(-250,-200)

    if isCollisionWalls(player_1_spawn_wall, bullet_player_1):
        bullet_player_1.hideturtle()
        bullet_player_1_state = "ready1"
        bullet_player_1.setposition(0, -400)
        player_1_spawn_wall.setposition(-250,-200)

    if isCollisionWalls(player_2_spawn_wall, bullet_player_1):
        bullet_player_1.hideturtle()
        bullet_player_1_state = "ready1"
        bullet_player_1.setposition(0,-400)
        player_2_spawn_wall.setposition(250,200)

    if isCollisionWalls(player_2_spawn_wall, bullet_player_2):
        bullet_player_2.hideturtle()
        bullet_player_2_state = "ready2"
        bullet_player_2.setposition(0,400)
        player_2_spawn_wall.setposition(250,200)

    if isCollisionMiddleWall(bullet_player_1, middle_player_wall):
        bullet_player_1.hideturtle()
        bullet_player_1_state = "ready1"
        bullet_player_1.setposition(0,-400)
        middle_player_wall.setposition(0,0)

    if isCollisionMiddleWall(bullet_player_2, middle_player_wall):
        bullet_player_2.hideturtle()
        bullet_player_2_state = "ready2"
        bullet_player_2.setposition(0,400)
        middle_player_wall.setposition(0,0)

    if isCollisionHealthbox(player_1, player_1_healthbox):
        player_1_healthbox.setposition(0,0)
        player_1_healthbox.hideturtle()
        player_1_health += 1
        pen.clear()
        pen.write("Player 1: Health {}    \t\t    Player 2: Health {}".format(player_1_health, player_2_health),align="center", font=("Bahnschrift", 24, "normal"))

    if isCollisionHealthbox(player_2, player_2_healthbox):
        player_2_healthbox.setposition(0,0)
        player_2_healthbox.hideturtle()
        player_2_health += 1
        pen.clear()
        pen.write("Player 1: Health {}    \t\t    Player 2: Health {}".format(player_1_health, player_2_health),align="center", font=("Bahnschrift", 24, "normal"))

    if isCollisionHealthbox(bullet_player_1, player_2_healthbox):
        player_2_healthbox.setposition(0,0)
        player_2_healthbox.hideturtle()
        bullet_player_1_state = "ready1"
        bullet_player_1.setposition(0,0)
        bullet_player_1.hideturtle()

    if isCollisionHealthbox(bullet_player_2, player_1_healthbox):
        player_1_healthbox.setposition(0,0)
        player_1_healthbox.hideturtle()
        bullet_player_2_state = "ready2"
        bullet_player_2.setposition(0,0)
        bullet_player_2.hideturtle()

    if player_1_health == 0 or player_2_health == 0:
        quit()