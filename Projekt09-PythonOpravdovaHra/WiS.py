import pygame
import sys


class GameState:
    def __init__(self):
        self.state = "intro"

    def intro(self):
        global intro_text, HARD_MODE
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_h:
                    HARD_MODE = True
                    click_start.play()
                    self.state = "tutorial"
                if event.key == pygame.K_n:
                    HARD_MODE = False
                    click_start.play()
                    self.state = "tutorial"

        screen.blit(BG_intro_surface, (0, 0))
        pygame.display.flip()

    def tutorial(self):
        global hero_movement, hero_speed, jump_state, HARD_MODE
        for event in pygame.event.get():
            if event.type == pygame.MOUSEBUTTONDOWN:
                click_start.play()
                hero_rect.x = 45
                hero_rect.y = 850
                hero_movement = 0

                self.state = "level_one"
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    first_level_start()
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()
        tutorial_box_collision()
        tutorial_box_two_collision()
        tutorial_box_three_collision()
        forty_first_box_collision()
        forty_second_box_collision()
        forty_third_box_collision()

        screen.blit(BG_tutorial_surface, (0, 0))

        pygame.draw.rect(screen, start_color, tutorial_box)
        pygame.draw.rect(screen, start_color, tutorial_box_two)
        pygame.draw.rect(screen, RED, tutorial_box_three)
        pygame.draw.rect(screen, start_color, forty_first_box)
        pygame.draw.rect(screen, RED, forty_second_box)
        pygame.draw.rect(screen, RED, forty_third_box)

        screen.blit(tutorial_text, (790, 150))
        screen.blit(TUTORIAL_text, (690, 25))

        screen.blit(hero_surface, hero_rect)
        pygame.display.flip()

    def level_one(self):
        global hero_movement, hero_speed, jump_state, level_two_state, HARD_MODE

        if level_two_state:
            hero_rect.x = 100
            hero_rect.y = 100
            hero_movement = 0
            self.state = "zero_cutscene"

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    first_level_start()
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()
        start_box_collision()
        second_box_collision()
        third_box_collision()
        fourth_box_collision()
        fifth_box_collision()
        sixth_box_collision()
        seventh_box_collision()
        eighth_box_collision()
        ninth_box_collision()
        tenth_box_collision()
        eleventh_box_collision()
        twelfth_box_collision()
        thirteenth_box_collision()
        finish_line_box_collision()

        square_moving_box_collision()

        screen.fill(light_grey)

        pygame.draw.rect(screen, start_color, start_box)
        pygame.draw.rect(screen, RED, second_box)
        pygame.draw.rect(screen, YELLOW, third_box)
        pygame.draw.rect(screen, BLUE, fourth_box)
        pygame.draw.rect(screen, GREEN, fifth_box)
        pygame.draw.rect(screen, RED, sixth_box)
        pygame.draw.rect(screen, PINK, eighth_box)
        pygame.draw.rect(screen, PINK, ninth_box)
        pygame.draw.rect(screen, PINK, tenth_box)
        pygame.draw.rect(screen, BLUE, eleventh_box)
        pygame.draw.rect(screen, RED, twelfth_box)
        pygame.draw.rect(screen, RED, square_moving_box)

        if not HARD_MODE:
            pygame.draw.rect(screen, PINK, seventh_box)
            pygame.draw.rect(screen, LIGHT_BLUE, thirteenth_box)
        if HARD_MODE:
            pygame.draw.rect(screen, light_grey, seventh_box)
            pygame.draw.rect(screen, light_grey, thirteenth_box)

        screen.blit(finish_line_surface, finish_line_rect)
        screen.blit(hero_surface, hero_rect)

        pygame.display.flip()

    def zero_cutscene(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "level_two"

        screen.blit(BG_zero_cutscene_surface, (0, 0))
        pygame.display.flip()

    def level_two(self):
        global hero_movement, hero_speed, jump_state, first_cutscene_state, HARD_MODE
        if first_cutscene_state:
            self.state = "first_cutscene_1"

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    second_level_start()
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()

        if HARD_MODE:
            bullet_shot()
            bullet_shot_collision()

        hero_friend_collision()

        fourteenth_box_collision()
        fifteenth_box_collision()
        sixteenth_box_collision()
        seventeenth_box_collision()
        eighteenth_box_collision()
        nineteenth_box_collision()
        twentieth_box_collision()
        twenty_first_box_collision()
        twenty_second_box_collision()
        twenty_third_box_collision()
        twenty_fourth_box_collision()
        twenty_fifth_box_collision()
        twenty_sixth_box_collision()
        twenty_seventh_box_collision()

        screen.fill(light_grey)

        pygame.draw.rect(screen, BLUE, fourteenth_box)
        pygame.draw.rect(screen, RED, fifteenth_box)
        pygame.draw.rect(screen, PINK, sixteenth_box)
        pygame.draw.rect(screen, WHITE, seventeenth_box)
        pygame.draw.rect(screen, WHITE, eighteenth_box)
        pygame.draw.rect(screen, WHITE, nineteenth_box)
        pygame.draw.rect(screen, WHITE, twentieth_box)
        pygame.draw.rect(screen, WHITE, twenty_first_box)
        pygame.draw.rect(screen, BLUE, twenty_second_box)
        pygame.draw.rect(screen, BLUE, twenty_third_box)
        pygame.draw.rect(screen, YELLOW, twenty_fourth_box)
        pygame.draw.rect(screen, GREEN, twenty_seventh_box)

        if not HARD_MODE:
            pygame.draw.rect(screen, RED, twenty_fifth_box)
            pygame.draw.rect(screen, YELLOW, twenty_sixth_box)
        if HARD_MODE:
            pygame.draw.rect(screen, light_grey, twenty_fifth_box)
            pygame.draw.rect(screen, light_grey, twenty_sixth_box)

        screen.blit(hero_surface, hero_rect)
        screen.blit(friend_in_case_surface, friend_in_case_rect)

        if HARD_MODE:
            screen.blit(enemy_surface_1, enemy_rect_1)
            screen.blit(enemy_surface_2, enemy_rect_2)

            screen.blit(bullet_surface_1, bullet_rect_1)
            screen.blit(bullet_surface_2, bullet_rect_2)

        pygame.display.flip()

    def first_cutscene_1(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "first_cutscene_2"

        screen.blit(BG_first_cutscene_1_surface, (0, 0))
        pygame.display.flip()

    def first_cutscene_2(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "first_cutscene_3"

        screen.blit(BG_first_cutscene_2_surface, (0, 0))
        pygame.display.flip()

    def first_cutscene_3(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "first_cutscene_4"

        screen.blit(BG_first_cutscene_3_surface, (0, 0))
        pygame.display.flip()

    def first_cutscene_4(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "first_cutscene_5"

        screen.blit(BG_first_cutscene_4_surface, (0, 0))
        pygame.display.flip()

    def first_cutscene_5(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "first_cutscene_6"

        screen.blit(BG_first_cutscene_5_surface, (0, 0))
        pygame.display.flip()

    def first_cutscene_6(self):
        global hero_movement
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                hero_rect.x = 100
                hero_rect.y = 100
                hero_movement = 0
                self.state = "find_the_key_level"

        screen.blit(BG_first_cutscene_6_surface, (0, 0))
        pygame.display.flip()

    def find_the_key_level(self):
        global hero_movement, hero_speed, jump_state, level_state, key_level_arrow_state, key_state
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    key_level_arrow_state = False
                    key_state = True
                    dead_sound.play()
                    hero_rect.x = 100
                    hero_rect.y = 100
                    hero_movement = 0
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()
        find_the_key_end()
        twenty_eighth_box_collision()
        twenty_ninth_box_collision()
        thirtieth_box_collision()
        thirty_first_box_collision()
        thirty_second_box_collision()
        thirty_third_box_collision()
        thirty_fourth_box_collision()
        thirty_fifth_box_collision()
        thirty_sixth_box_collision()

        hero_key_collision()
        if key_level_arrow_state:
            screen.blit(BG_key_level_arrow_surface, (0, 0))
            pygame.draw.rect(screen, light_grey, find_the_key_level_finish_box)
            if level_find_the_key_state:
                self.state = "second_cutscene_1"
        if not key_level_arrow_state:
            screen.fill(light_grey)

        pygame.draw.rect(screen, RED, twenty_eighth_box)
        pygame.draw.rect(screen, GREEN, twenty_ninth_box)
        pygame.draw.rect(screen, BLUE, thirtieth_box)
        pygame.draw.rect(screen, PINK, thirty_first_box)
        pygame.draw.rect(screen, GREEN, thirty_second_box)
        pygame.draw.rect(screen, BLUE, thirty_third_box)
        pygame.draw.rect(screen, YELLOW, thirty_fourth_box)
        pygame.draw.rect(screen, PINK, thirty_sixth_box)

        if not HARD_MODE:
            pygame.draw.rect(screen, BLUE, thirty_fifth_box)
        if HARD_MODE:
            pygame.draw.rect(screen, light_grey, thirty_fifth_box)

        screen.blit(hero_surface, hero_rect)
        if key_state:
            screen.blit(key_surface, key_rect)
        pygame.display.flip()

    def second_cutscene_1(self):
        global hero_movement
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "second_cutscene_2"

        screen.blit(BG_second_cutscene_1_surface, (0, 0))
        pygame.display.flip()

    def second_cutscene_2(self):
        global hero_movement
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "second_cutscene_3"

        screen.blit(BG_second_cutscene_2_surface, (0, 0))
        pygame.display.flip()

    def second_cutscene_3(self):
        global hero_movement
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "second_cutscene_4"

        screen.blit(BG_second_cutscene_3_surface, (0, 0))
        pygame.display.flip()

    def second_cutscene_4(self):
        global hero_movement
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "level_three"
                third_level_start()

        screen.blit(BG_second_cutscene_4_surface, (0, 0))
        pygame.display.flip()

    def third_level(self):
        global hero_movement, jump_state, hero_speed, call_friend_state, friend_speed, collision_tolerance
        global level_three_text_ready, boss_enemy_speed, level_three_text_disappear, boss_can_go, boss_bullet_shoot
        global boss_bullet_ready, boss_stops_state

        if level_three_state:
            self.state = "third_cutscene_1"

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_c:
                    if call_friend_state:
                        friend_speed = +4
                if event.key == pygame.K_r:
                    boss_enemy_rect.x = 2000
                    boss_enemy_speed = 0
                    boss_can_go = True
                    friend_rect.x = 25
                    friend_speed = 0
                    third_level_start()
                    call_friend_state = False
                    level_three_text_ready = False
                    level_three_text_disappear = True
                    boss_bullet_shoot = False
                    boss_bullet_ready = False
                    boss_bullet_rect.x = 1450
                    boss_stops_state = False
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()

        friend_move()
        moving_friend_hero_collision()
        friend_collision_wall()

        boss_enemy_move()
        boss_stops()
        if boss_stops_state:
            boss_bullet_shot()
            boss_bullet_hero_collision()

        hero_boss_collision()

        thirty_seventh_box_collision()
        thirty_eighth_box_collision()
        thirty_ninth_box_collision()
        fortieth_box_collision()

        if call_friend_state:
            screen.blit(BG_callable_friend_surface, (0, 0))
        else:
            screen.fill(light_grey)

        if jump_on_boss_state:
            screen.blit(BG_jump_on_boss_surface, (0, 0))

        pygame.draw.rect(screen, RED, thirty_seventh_box)
        pygame.draw.rect(screen, BLUE, thirty_eighth_box)
        pygame.draw.rect(screen, GREEN, thirty_ninth_box)
        pygame.draw.rect(screen, LIGHT_BLUE, fortieth_box)

        screen.blit(hero_surface, hero_rect)
        screen.blit(friend_surface, friend_rect)
        screen.blit(boss_enemy_surface, boss_enemy_rect)

        if level_three_text_ready and level_three_text_disappear:
            screen.blit(friend_run_text, (hero_rect.x - 110, hero_rect.y - 50))

        if boss_bullet_ready:
            screen.blit(boss_bullet_surface, boss_bullet_rect)

        pygame.display.flip()

    def third_cutscene_1(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "third_cutscene_2"

        screen.blit(BG_third_cutscene_1_surface, (0, 0))
        pygame.display.flip()

    def third_cutscene_2(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "third_cutscene_3"

        screen.blit(BG_third_cutscene_2_surface, (0, 0))
        pygame.display.flip()

    def third_cutscene_3(self):
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                self.state = "third_cutscene_4"

        screen.blit(BG_third_cutscene_3_surface, (0, 0))
        pygame.display.flip()

    def third_cutscene_4(self):
        global hero_speed
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                hero_rect.x = 50
                hero_rect.y = 900
                hero_speed = 0
                self.state = "level_four"

        screen.blit(BG_third_cutscene_4_surface, (0, 0))
        pygame.display.flip()

    def level_four(self):
        global jump_state, hero_speed, hero_movement, level_state

        if level_four_state:
            hero_speed = 0
            self.state = "fourth_cutscene_1"
            level_state = "fifth_level"

        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    fourth_level_start()
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
                if event.key == pygame.K_SPACE:
                    if jump_state:
                        hero_movement = 0
                        hero_movement -= 12
                        jump_state = False
                        sound.play()
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5

        gravity()
        side_borders()
        hero_move()

        forty_fourth_box_collision()
        forty_fifth_box_collision()
        forty_sixth_box_collision()
        forty_seventh_box_collision()
        forty_eighth_box_collision()
        forty_ninth_box_collision()
        fiftieth_box_collision()
        fifty_first_box_collision()
        fifty_second_box_collision()

        moving_collision_fiftieth_box()

        level_four_finish_line_collision()

        screen.fill(light_grey)

        pygame.draw.rect(screen, BLUE, forty_fourth_box)
        pygame.draw.rect(screen, YELLOW, forty_fifth_box)
        pygame.draw.rect(screen, RED, forty_sixth_box)
        pygame.draw.rect(screen, GREEN, forty_seventh_box)
        pygame.draw.rect(screen, PINK, forty_eighth_box)
        pygame.draw.rect(screen, YELLOW, forty_ninth_box)
        pygame.draw.rect(screen, RED, fiftieth_box)
        pygame.draw.rect(screen, LIGHT_BLUE, fifty_first_box)
        pygame.draw.rect(screen, BLUE, fifty_second_box)

        screen.blit(level_four_finish_line_surface, level_four_finish_line_rect)
        screen.blit(hero_surface, hero_rect)

        pygame.display.flip()

    def fourth_cutscene_1(self):
        global hero_speed, level_state, hero_movement, jump_state
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
            if event.type == pygame.MOUSEBUTTONDOWN:
                hero_rect.x = 50
                hero_rect.y = 50
                hero_movement = 0
                click_start.play()
                self.state = "level_five"
                jump_state = False

        screen.blit(BG_fourth_cutscene_1_surface, (0, 0))
        pygame.display.flip()

    def level_five(self):
        global hero_movement, hero_speed, jump_state, HARD_MODE, click_ready, x, endgame_state
        for event in pygame.event.get():
            if event.type == pygame.MOUSEBUTTONDOWN:
                if click_ready:
                    x += 1
                if endgame_state:
                    self.state = "fifth_cutscene_1"

            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()
                if event.key == pygame.K_r:
                    fifth_level_start()
                if event.key == pygame.K_LEFT:
                    hero_speed -= 5
                if event.key == pygame.K_RIGHT:
                    hero_speed += 5
            if event.type == pygame.KEYUP:
                if event.key == pygame.K_LEFT:
                    hero_speed += 5
                if event.key == pygame.K_RIGHT:
                    hero_speed -= 5
        gravity()
        side_borders()
        hero_move()

        fifty_third_box_collision()
        fifty_fourth_box_collision()

        if hero_touch_floor:
            click_ready = True
            if x == 1:
                screen.blit(BG_level_five_surface, (0, 0))
            if x == 2:
                screen.blit(BG_level_five_2_surface, (0, 0))
            if x == 3:
                screen.blit(BG_level_five_3_surface, (0, 0))
            if x == 4:
                screen.blit(BG_level_five_4_surface, (0, 0))
            if x == 5:
                screen.blit(BG_level_five_5_surface, (0, 0))
            if x == 6:
                screen.blit(BG_level_five_6_surface, (0, 0))
            if x == 7:
                endgame_state = True
        else:
            screen.fill(light_grey)

        screen.blit(hero_surface, hero_rect)
        screen.blit(final_boss_surface, final_boss_rect)
        screen.blit(my_love_surface, (screen_width - 50, 100))

        pygame.draw.rect(screen, LIGHT_BLUE, fifty_third_box)
        pygame.draw.rect(screen, BLUE, fifty_fourth_box)

        pygame.draw.rect(screen, PINK, fifty_fifth_box)

        pygame.display.flip()

    def fifth_cutscene_1(self):
        global hero_speed, level_state, hero_movement, jump_state
        for event in pygame.event.get():
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    pygame.quit()
                    sys.exit()

        screen.blit(GB_level_five_end_surface, (0, 0))
        pygame.display.flip()

    def state_manager(self):
        global level_state, hero_speed, reset_hero_speed_0
        if self.state == "intro":
            self.intro()
        if self.state == "tutorial":
            self.tutorial()
        if self.state == "level_one":
            level_state = "first_level"
            self.level_one()
        if self.state == "zero_cutscene":
            self.zero_cutscene()
        if self.state == "level_two":
            level_state = "second_level"
            self.level_two()
        if self.state == "first_cutscene_1":
            self.first_cutscene_1()
        if self.state == "first_cutscene_2":
            self.first_cutscene_2()
        if self.state == "first_cutscene_3":
            self.first_cutscene_3()
        if self.state == "first_cutscene_4":
            self.first_cutscene_4()
        if self.state == "first_cutscene_5":
            self.first_cutscene_5()
        if self.state == "first_cutscene_6":
            self.first_cutscene_6()
        if self.state == "find_the_key_level":
            level_state = "find_the_key_level"
            self.find_the_key_level()
        if self.state == "second_cutscene_1":
            self.second_cutscene_1()
        if self.state == "second_cutscene_2":
            self.second_cutscene_2()
        if self.state == "second_cutscene_3":
            self.second_cutscene_3()
        if self.state == "second_cutscene_4":
            self.second_cutscene_4()
            level_state = "third_level"
        if self.state == "level_three":
            self.third_level()
        if self.state == "third_cutscene_1":
            self.third_cutscene_1()
        if self.state == "third_cutscene_2":
            self.third_cutscene_2()
        if self.state == "third_cutscene_3":
            self.third_cutscene_3()
        if self.state == "third_cutscene_4":
            self.third_cutscene_4()
        if self.state == "level_four":
            level_state = "level_four"
            self.level_four()
        if self.state == "fourth_cutscene_1":
            self.fourth_cutscene_1()
        if self.state == "level_five":
            level_state = "fifth_level"
            self.level_five()
        if self.state == "fifth_cutscene_1":
            self.fifth_cutscene_1()


def gravity():
    global hero_movement
    hero_movement += GRAVITY
    hero_rect.centery += hero_movement


def boss_enemy_move():
    boss_enemy_rect.x += boss_enemy_speed


def hero_move():
    hero_rect.x += hero_speed


def friend_move():
    friend_rect.x += friend_speed


def hero_key_collision():
    global key_state, key_level_arrow_state
    if hero_rect.colliderect(key_rect) or key_rect.colliderect(hero_rect):
        if key_state:
            click_start.play()
        key_state = False
        key_level_arrow_state = True


def hero_friend_collision():
    global first_cutscene_state, hero_speed
    if hero_rect.colliderect(friend_in_case_rect) or friend_in_case_rect.colliderect(hero_rect):
        first_cutscene_state = True
        hero_speed = 0
        click_start.play()


def hero_boss_collision():
    global hero_movement, collision_tolerance, level_three_state
    if hero_rect.colliderect(boss_enemy_rect) or boss_enemy_rect.colliderect(hero_rect):
        if abs(hero_rect.bottom - boss_enemy_rect.top) < collision_tolerance:
            hero_rect.bottom = boss_enemy_rect.top
            hero_movement = 0
            level_three_state = True
            click_start.play()
        if abs(hero_rect.right - boss_enemy_rect.left) < collision_tolerance:
            hero_rect.right = boss_enemy_rect.left
        if abs(hero_rect.left - boss_enemy_rect.right) < collision_tolerance:
            hero_rect.left = boss_enemy_rect.right


def friend_collision_wall():
    global friend_speed
    if friend_rect.x > 215:
        friend_rect.x = 215
        friend_speed = 0


def boss_stops():
    global boss_enemy_speed, boss_can_go, level_three_text_disappear, boss_bullet_ready, boss_bullet_shoot
    global boss_stops_state
    global jump_on_boss_state
    if boss_enemy_rect.x < 1500:
        boss_enemy_speed = 0
        boss_can_go = False
        level_three_text_disappear = False
        boss_bullet_ready = True
        boss_bullet_shoot = True
        jump_on_boss_state = True
        boss_stops_state = True


def boss_bullet_shot():
    global bullet_speed
    if boss_bullet_shoot:
        boss_bullet_rect.x -= boss_bullet_speed
    if boss_bullet_rect.x <= 375:
        boss_bullet_rect.x = boss_bullet_rect.x + boss_bullet_rect.y + 100
        boss_gunshot.play()


def moving_friend_hero_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(friend_rect) or friend_rect.colliderect(hero_rect):
        if abs(hero_rect.bottom - friend_rect.top) < collision_tolerance:
            hero_rect.bottom = friend_rect.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - friend_rect.bottom) < collision_tolerance:
            hero_rect.top = friend_rect.bottom
            hero_movement = 0
        if abs(hero_rect.right - friend_rect.left) < collision_tolerance:
            hero_rect.right = friend_rect.left
        if abs(hero_rect.left - friend_rect.right) < collision_tolerance:
            hero_rect.left = friend_rect.right


def bullet_shot():
    global bullet_speed
    if bullet_1_state:
        bullet_rect_1.x -= bullet_speed
    if not bullet_1_state:
        bullet_rect_1.x = screen_height * 2
    if bullet_2_state:
        bullet_rect_2.x -= bullet_speed
    if not bullet_2_state:
        bullet_rect_2.x = screen_height * 2

    if bullet_rect_1.x <= 0:
        bullet_rect_1.x = 1600
        gunshot.play()
    if bullet_rect_2.x <= 0:
        bullet_rect_2.x = 1765
        gunshot.play()


def boss_bullet_hero_collision():
    global boss_enemy_speed, boss_can_go, friend_speed, call_friend_state, level_three_text_ready
    global level_three_text_disappear, boss_bullet_ready, boss_bullet_shoot, boss_stops_state

    if hero_rect.colliderect(boss_bullet_rect) or boss_bullet_rect.colliderect(hero_rect):
        third_level_start()
        boss_enemy_rect.x = 2000
        boss_enemy_speed = 0
        boss_can_go = True
        friend_rect.x = 25
        friend_speed = 0
        third_level_start()
        call_friend_state = False
        level_three_text_ready = False
        level_three_text_disappear = True
        boss_bullet_shoot = False
        boss_bullet_ready = False
        boss_bullet_rect.x = 1450
        boss_stops_state = False


def bullet_shot_collision():
    if bullet_rect_1.colliderect(hero_rect) or bullet_rect_2.colliderect(hero_rect):
        second_level_start()


def first_level_start():
    global hero_movement
    dead_sound.play()
    hero_rect.x = 45
    hero_rect.y = 850
    hero_movement = 0


def second_level_start():
    global hero_movement, bullet_1_state, bullet_2_state
    dead_sound.play()
    hero_rect.x = 100
    hero_rect.y = 100
    hero_movement = 0
    bullet_1_state = True
    bullet_2_state = True


def third_level_start():
    global hero_movement
    dead_sound.play()
    hero_rect.x = 100
    hero_rect.y = 750
    hero_movement = 0


def find_the_key_level_start():
    global hero_movement, key_level_arrow_state, key_state
    dead_sound.play()
    hero_rect.x = 100
    hero_rect.y = 100
    hero_movement = 0
    key_level_arrow_state = False
    key_state = True


def fourth_level_start():
    global hero_movement
    dead_sound.play()
    hero_movement = 0
    hero_rect.x = 50
    hero_rect.y = 900


def fifth_level_start():
    global hero_movement
    dead_sound.play()
    hero_movement = 0
    hero_rect.x = 50
    hero_rect.y = 50


def find_the_key_end():
    global level_find_the_key_state, hero_speed, level_state
    if key_level_arrow_state:
        if hero_rect.colliderect(find_the_key_level_finish_box):
            level_state = "third_level"
            level_find_the_key_state = True
            hero_speed = 0
            click_start.play()


def side_borders():
    global hero_movement
    if hero_rect.bottom >= screen_height + 10:
        if level_state == "first_level":
            first_level_start()
        if level_state == "second_level":
            second_level_start()
        if level_state == "find_the_key_level":
            find_the_key_level_start()
        if level_state == "third_level":
            third_level_start()
        if level_state == "level_four":
            fourth_level_start()
        if level_state == "fifth_level":
            fifth_level_start()
    if hero_rect.right >= screen_width:
        hero_rect.right = screen_width
    if hero_rect.left <= 0:
        hero_rect.left = 0
    if hero_rect.top <= 0:
        hero_rect.top = 0
        hero_movement = 0


def finish_line_box_collision():
    global level_two_state, level_state, hero_speed, reset_hero_speed_0
    if hero_rect.colliderect(finish_line_rect) or finish_line_rect.colliderect(hero_rect):
        level_two_state = True
        level_state = "second_level"
        hero_speed = 0
        click_start.play()


def tutorial_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(tutorial_box) or tutorial_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - tutorial_box.top) < collision_tolerance:
            hero_rect.bottom = tutorial_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - tutorial_box.right) < collision_tolerance:
            hero_rect.left = tutorial_box.right


def tutorial_box_two_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(tutorial_box_two) or tutorial_box_two.colliderect(hero_rect):
        if abs(hero_rect.bottom - tutorial_box_two.top) < collision_tolerance:
            hero_rect.bottom = tutorial_box_two.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - tutorial_box_two.left) < collision_tolerance:
            hero_rect.right = tutorial_box_two.left


def tutorial_box_three_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(tutorial_box_three) or tutorial_box_three.colliderect(hero_rect):
        if abs(hero_rect.bottom - tutorial_box_three.top) < collision_tolerance:
            hero_rect.bottom = tutorial_box_three.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - tutorial_box_three.bottom) < collision_tolerance:
            hero_rect.top = tutorial_box_three.bottom
        if abs(hero_rect.right - tutorial_box_three.left) < collision_tolerance:
            hero_rect.right = tutorial_box_three.left
        if abs(hero_rect.left - tutorial_box_three.right) < collision_tolerance:
            hero_rect.left = tutorial_box_three.right


def start_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(start_box) or start_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - start_box.top) < collision_tolerance:
            hero_rect.bottom = start_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - start_box.right) < collision_tolerance:
            hero_rect.left = start_box.right


def second_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(second_box) or second_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - second_box.top) < collision_tolerance:
            hero_rect.bottom = second_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - second_box.left) < collision_tolerance:
            hero_rect.right = second_box.left
        if abs(hero_rect.left - second_box.right) < collision_tolerance:
            hero_rect.left = second_box.right


def third_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(third_box) or third_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - third_box.top) < collision_tolerance:
            hero_rect.bottom = third_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - third_box.left) < collision_tolerance:
            hero_rect.right = third_box.left
        if abs(hero_rect.left - third_box.right) < collision_tolerance:
            hero_rect.left = third_box.right


def fourth_box_collision():
    global collision_tolerance
    if hero_rect.colliderect(fourth_box) or fourth_box.colliderect(hero_rect):
        if abs(hero_rect.right - fourth_box.left) < collision_tolerance:
            hero_rect.right = fourth_box.left
        if abs(hero_rect.top - fourth_box.bottom) < collision_tolerance:
            hero_rect.top = fourth_box.bottom
        if abs(hero_rect.left - fourth_box.right) < collision_tolerance:
            hero_rect.left = fourth_box.right


def fifth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fifth_box) or fifth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fifth_box.top) < collision_tolerance:
            hero_rect.bottom = fifth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - fifth_box.left) < collision_tolerance:
            hero_rect.right = fifth_box.left
        if abs(hero_rect.left - fifth_box.right) < collision_tolerance:
            hero_rect.left = fifth_box.right


def sixth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(sixth_box) or sixth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - sixth_box.top) < collision_tolerance:
            hero_rect.bottom = sixth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - sixth_box.left) < collision_tolerance:
            hero_rect.right = sixth_box.left


def seventh_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(seventh_box) or seventh_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - seventh_box.top) < collision_tolerance:
            hero_rect.bottom = seventh_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - seventh_box.left) < collision_tolerance:
            hero_rect.right = seventh_box.left
        if abs(hero_rect.left - seventh_box.right) < collision_tolerance:
            hero_rect.left = seventh_box.right


def eighth_box_collision():
    global collision_tolerance, jump_state, hero_movement
    if hero_rect.colliderect(eighth_box) or eighth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - eighth_box.top) < collision_tolerance:
            hero_rect.bottom = eighth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - eighth_box.bottom) < collision_tolerance:
            hero_rect.top = eighth_box.bottom
        if abs(hero_rect.right - eighth_box.left) < collision_tolerance:
            hero_rect.right = eighth_box.left
        if abs(hero_rect.left - eighth_box.right) < collision_tolerance:
            hero_rect.left = eighth_box.right


def ninth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(ninth_box) or ninth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - ninth_box.top) < collision_tolerance:
            hero_rect.bottom = ninth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - ninth_box.bottom) < collision_tolerance:
            hero_rect.top = ninth_box.bottom
        if abs(hero_rect.left - ninth_box.right) < collision_tolerance:
            hero_rect.left = ninth_box.right


def tenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(tenth_box) or tenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - tenth_box.top) < collision_tolerance:
            hero_rect.bottom = tenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - tenth_box.bottom) < collision_tolerance:
            hero_rect.top = tenth_box.bottom
        if abs(hero_rect.right - tenth_box.left) < collision_tolerance:
            hero_rect.right = tenth_box.left


def eleventh_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(eleventh_box) or eleventh_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - eleventh_box.top) < collision_tolerance:
            hero_rect.bottom = eleventh_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - eleventh_box.bottom) < collision_tolerance:
            hero_rect.top = eleventh_box.bottom
            hero_movement = 0


def twelfth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twelfth_box) or twelfth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twelfth_box.top) < collision_tolerance:
            hero_rect.bottom = twelfth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - twelfth_box.left) < collision_tolerance:
            hero_rect.right = twelfth_box.left
        if abs(hero_rect.left - twelfth_box.right) < collision_tolerance:
            hero_rect.left = twelfth_box.right


def thirteenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirteenth_box) or thirteenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirteenth_box.top) < collision_tolerance:
            hero_rect.bottom = thirteenth_box.top
            hero_movement = 0
            jump_state = True


def square_moving_box_collision():
    global moving_rect_speed, jump_state, hero_movement, collision_tolerance
    square_moving_box.x -= moving_rect_speed

    if square_moving_box.left <= 350:
        moving_rect_speed *= -1
    if square_moving_box.right >= 1350:
        moving_rect_speed *= -1

    if hero_rect.colliderect(square_moving_box) or square_moving_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - square_moving_box.top) < collision_tolerance:
            hero_rect.bottom = square_moving_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - square_moving_box.right) < collision_tolerance:
            hero_rect.left = square_moving_box.right
        if abs(hero_rect.right - square_moving_box.left) < collision_tolerance:
            hero_rect.right = square_moving_box.left


def fourteenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fourteenth_box) or fourteenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fourteenth_box.top) < collision_tolerance:
            hero_rect.bottom = fourteenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - fourteenth_box.bottom) < collision_tolerance:
            hero_rect.top = fourteenth_box.bottom
            hero_movement = 0
        if abs(hero_rect.left - fourteenth_box.right) < collision_tolerance:
            hero_rect.left = fourteenth_box.right


def fifteenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fifteenth_box) or fifteenth_box.colliderect(hero_rect):
        if abs(hero_rect.right - fifteenth_box.left) < collision_tolerance:
            hero_rect.right = fifteenth_box.left
        if abs(hero_rect.top - fifteenth_box.bottom) < collision_tolerance:
            hero_rect.top = fifteenth_box.bottom
        if abs(hero_rect.left - fifteenth_box.right) < collision_tolerance:
            hero_rect.left = fifteenth_box.right


def sixteenth_box_collision():
    global jump_state, collision_tolerance, hero_movement
    if hero_rect.colliderect(sixteenth_box) or sixteenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - sixteenth_box.top) < collision_tolerance:
            hero_rect.bottom = sixteenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - sixteenth_box.bottom) < collision_tolerance:
            hero_rect.top = sixteenth_box.bottom
            hero_movement = 0
        if abs(hero_rect.left - sixteenth_box.right) < collision_tolerance:
            hero_rect.left = sixteenth_box.right
        if abs(hero_rect.right - sixteenth_box.left) < collision_tolerance:
            hero_rect.right = sixteenth_box.left


def seventeenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(seventeenth_box) or seventeenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - seventeenth_box.top) < collision_tolerance:
            hero_rect.bottom = seventeenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - seventeenth_box.right) < collision_tolerance:
            hero_rect.left = seventeenth_box.right
        if abs(hero_rect.right - seventeenth_box.left) < collision_tolerance:
            hero_rect.right = seventeenth_box.left


def eighteenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(eighteenth_box) or eighteenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - eighteenth_box.top) < collision_tolerance:
            hero_rect.bottom = eighteenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - eighteenth_box.bottom) < collision_tolerance:
            hero_rect.top = eighteenth_box.bottom
        if abs(hero_rect.right - eighteenth_box.left) < collision_tolerance:
            hero_rect.right = eighteenth_box.left
        if abs(hero_rect.left - eighteenth_box.right) < collision_tolerance:
            hero_rect.left = eighteenth_box.right


def nineteenth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(nineteenth_box) or nineteenth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - nineteenth_box.top) < collision_tolerance:
            hero_rect.bottom = nineteenth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - nineteenth_box.bottom) < collision_tolerance:
            hero_rect.top = nineteenth_box.bottom
        if abs(hero_rect.right - nineteenth_box.left) < collision_tolerance:
            hero_rect.right = nineteenth_box.left
        if abs(hero_rect.left - nineteenth_box.right) < collision_tolerance:
            hero_rect.left = nineteenth_box.right


def twentieth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twentieth_box) or twentieth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twentieth_box.top) < collision_tolerance:
            hero_rect.bottom = twentieth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twentieth_box.bottom) < collision_tolerance:
            hero_rect.top = twentieth_box.bottom
        if abs(hero_rect.right - twentieth_box.left) < collision_tolerance:
            hero_rect.right = twentieth_box.left
        if abs(hero_rect.left - twentieth_box.right) < collision_tolerance:
            hero_rect.left = twentieth_box.right


def twenty_first_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_first_box) or twenty_first_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_first_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_first_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twenty_first_box.bottom) < collision_tolerance:
            hero_rect.top = twenty_first_box.bottom
        if abs(hero_rect.right - twenty_first_box.left) < collision_tolerance:
            hero_rect.right = twenty_first_box.left
        if abs(hero_rect.left - twenty_first_box.right) < collision_tolerance:
            hero_rect.left = twenty_first_box.right


def twenty_second_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_second_box) or twenty_second_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_second_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_second_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - twenty_second_box.left) < collision_tolerance:
            hero_rect.right = twenty_second_box.left


def twenty_third_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_third_box) or twenty_third_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_third_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_third_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - twenty_third_box.left) < collision_tolerance:
            hero_rect.right = twenty_third_box.left


def twenty_fourth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_fourth_box) or twenty_fourth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_fourth_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_fourth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twenty_fourth_box.bottom) < collision_tolerance:
            hero_rect.top = twenty_fourth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - twenty_fourth_box.left) < collision_tolerance:
            hero_rect.right = twenty_fourth_box.left


def twenty_fifth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_fifth_box) or twenty_fifth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_fifth_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_fifth_box.top
            hero_movement = 0
            jump_state = True

        if abs(hero_rect.right - twenty_fifth_box.left) < collision_tolerance:
            hero_rect.right = twenty_fifth_box.left
        if abs(hero_rect.left - twenty_fifth_box.right) < collision_tolerance:
            hero_rect.left = twenty_fifth_box.right


def twenty_sixth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_sixth_box) or twenty_sixth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_sixth_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_sixth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - twenty_sixth_box.left) < collision_tolerance:
            hero_rect.right = twenty_sixth_box.left
        if abs(hero_rect.left - twenty_sixth_box.right) < collision_tolerance:
            hero_rect.left = twenty_sixth_box.right


def twenty_seventh_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_seventh_box) or twenty_seventh_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_seventh_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_seventh_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twenty_seventh_box.bottom) < collision_tolerance:
            hero_rect.top = twenty_seventh_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - twenty_seventh_box.left) < collision_tolerance:
            hero_rect.right = twenty_seventh_box.left


def twenty_eighth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_eighth_box) or twenty_eighth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_eighth_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_eighth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twenty_eighth_box.bottom) < collision_tolerance:
            hero_rect.top = twenty_eighth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - twenty_eighth_box.left) < collision_tolerance:
            hero_rect.right = twenty_eighth_box.left
        if abs(hero_rect.left - twenty_eighth_box.right) < collision_tolerance:
            hero_rect.left = twenty_eighth_box.right


def twenty_ninth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(twenty_ninth_box) or twenty_ninth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - twenty_ninth_box.top) < collision_tolerance:
            hero_rect.bottom = twenty_ninth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - twenty_ninth_box.bottom) < collision_tolerance:
            hero_rect.top = twenty_ninth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - twenty_ninth_box.left) < collision_tolerance:
            hero_rect.right = twenty_ninth_box.left
        if abs(hero_rect.left - twenty_ninth_box.right) < collision_tolerance:
            hero_rect.left = twenty_ninth_box.right


def thirtieth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirtieth_box) or thirtieth_box.colliderect(hero_rect):
        if abs(hero_rect.right - thirtieth_box.left) < collision_tolerance:
            hero_rect.right = thirtieth_box.left
        if abs(hero_rect.left - thirtieth_box.right) < collision_tolerance:
            hero_rect.left = thirtieth_box.right


def thirty_first_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirty_first_box) or thirty_first_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_first_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_first_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_first_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_first_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - thirty_first_box.left) < collision_tolerance:
            hero_rect.right = thirty_first_box.left
        if abs(hero_rect.left - thirty_first_box.right) < collision_tolerance:
            hero_rect.left = thirty_first_box.right


def thirty_second_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(thirty_second_box) or thirty_second_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_second_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_second_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_second_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_second_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - thirty_second_box.left) < collision_tolerance:
            hero_rect.right = thirty_second_box.left
        if abs(hero_rect.left - thirty_second_box.right) < collision_tolerance:
            hero_rect.left = thirty_second_box.right


def thirty_third_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirty_third_box) or thirty_third_box.colliderect(hero_rect):
        if abs(hero_rect.right - thirty_third_box.left) < collision_tolerance:
            hero_rect.right = thirty_third_box.left


def thirty_fourth_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(thirty_fourth_box) or thirty_fourth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_fourth_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_fourth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_fourth_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_fourth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - thirty_fourth_box.left) < collision_tolerance:
            hero_rect.right = thirty_fourth_box.left
        if abs(hero_rect.left - thirty_fourth_box.right) < collision_tolerance:
            hero_rect.left = thirty_fourth_box.right

            
def thirty_fifth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirty_fifth_box) or thirty_fifth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_fifth_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_fifth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_fifth_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_fifth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - thirty_fifth_box.left) < collision_tolerance:
            hero_rect.right = thirty_fifth_box.left
        if abs(hero_rect.left - thirty_fifth_box.right) < collision_tolerance:
            hero_rect.left = thirty_fifth_box.right


def thirty_sixth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(thirty_sixth_box) or thirty_sixth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_sixth_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_sixth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_sixth_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_sixth_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - thirty_sixth_box.left) < collision_tolerance:
            hero_rect.right = thirty_sixth_box.left
        if abs(hero_rect.left - thirty_sixth_box.right) < collision_tolerance:
            hero_rect.left = thirty_sixth_box.right


def thirty_seventh_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(thirty_seventh_box) or thirty_seventh_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_seventh_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_seventh_box.top
            hero_movement = 0
            jump_state = True


def thirty_eighth_box_collision():
    global hero_movement, jump_state, collision_tolerance, call_friend_state
    if hero_rect.colliderect(thirty_eighth_box) or thirty_eighth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_eighth_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_eighth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - thirty_eighth_box.left) < collision_tolerance:
            hero_rect.right = thirty_eighth_box.left
            call_friend_state = True
        if abs(hero_rect.left - thirty_eighth_box.right) < collision_tolerance:
            hero_rect.left = thirty_eighth_box.right


def thirty_ninth_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(thirty_ninth_box) or thirty_ninth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - thirty_ninth_box.top) < collision_tolerance:
            hero_rect.bottom = thirty_ninth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - thirty_ninth_box.bottom) < collision_tolerance:
            hero_rect.top = thirty_ninth_box.bottom
            hero_movement = 0
        if abs(hero_rect.left - thirty_ninth_box.right) < collision_tolerance:
            hero_rect.left = thirty_ninth_box.right


def fortieth_box_collision():
    global jump_state, hero_movement, collision_tolerance, call_friend_state, friend_speed, level_three_text_ready
    global boss_enemy_speed
    if hero_rect.colliderect(fortieth_box) or fortieth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fortieth_box.top) < collision_tolerance:
            hero_rect.bottom = fortieth_box.top
            hero_movement = 0
            jump_state = True
            call_friend_state = False
            friend_speed = -4
            level_three_text_ready = True
            if boss_can_go:
                boss_enemy_speed = -4


def forty_first_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_first_box) or forty_first_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_first_box.top) < collision_tolerance:
            hero_rect.bottom = forty_first_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_first_box.bottom) < collision_tolerance:
            hero_rect.top = forty_first_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - forty_first_box.left) < collision_tolerance:
            hero_rect.right = forty_first_box.left
        if abs(hero_rect.left - forty_first_box.right) < collision_tolerance:
            hero_rect.left = forty_first_box.right


def forty_second_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_second_box) or forty_second_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_second_box.top) < collision_tolerance:
            hero_rect.bottom = forty_second_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_second_box.bottom) < collision_tolerance:
            hero_rect.top = forty_second_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - forty_second_box.left) < collision_tolerance:
            hero_rect.right = forty_second_box.left
        if abs(hero_rect.left - forty_second_box.right) < collision_tolerance:
            hero_rect.left = forty_second_box.right


def forty_third_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_third_box) or forty_third_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_third_box.top) < collision_tolerance:
            hero_rect.bottom = forty_third_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_third_box.bottom) < collision_tolerance:
            hero_rect.top = forty_third_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - forty_third_box.left) < collision_tolerance:
            hero_rect.right = forty_third_box.left
        if abs(hero_rect.left - forty_third_box.right) < collision_tolerance:
            hero_rect.left = forty_third_box.right


def forty_fourth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(forty_fourth_box) or forty_fourth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_fourth_box.top) < collision_tolerance:
            hero_rect.bottom = forty_fourth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - forty_fourth_box.right) < collision_tolerance:
            hero_rect.left = forty_fourth_box.right


def forty_fifth_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_fifth_box) or forty_fifth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_fifth_box.top) < collision_tolerance:
            hero_rect.bottom = forty_fifth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_fifth_box.bottom) < collision_tolerance:
            hero_rect.top = forty_fifth_box.bottom
            hero_movement = 0
        if abs(hero_rect.left - forty_fifth_box.right) < collision_tolerance:
            hero_rect.left = forty_fifth_box.right


def forty_sixth_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_sixth_box) or forty_sixth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_sixth_box.top) < collision_tolerance:
            hero_rect.bottom = forty_sixth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - forty_sixth_box.left) < collision_tolerance:
            hero_rect.right = forty_sixth_box.left
        if abs(hero_rect.left - forty_sixth_box.right) < collision_tolerance:
            hero_rect.left = forty_sixth_box.right


def forty_seventh_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(forty_seventh_box) or forty_seventh_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_seventh_box.top) < collision_tolerance:
            hero_rect.bottom = forty_seventh_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - forty_seventh_box.left) < collision_tolerance:
            hero_rect.right = forty_seventh_box.left


def forty_eighth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(forty_eighth_box) or forty_eighth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_eighth_box.top) < collision_tolerance:
            hero_rect.bottom = forty_eighth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_eighth_box.bottom) < collision_tolerance:
            hero_rect.top = forty_eighth_box.bottom
        if abs(hero_rect.left - forty_eighth_box.right) < collision_tolerance:
            hero_rect.left = forty_eighth_box.right


def forty_ninth_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(forty_ninth_box) or forty_ninth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - forty_ninth_box.top) < collision_tolerance:
            hero_rect.bottom = forty_ninth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - forty_ninth_box.bottom) < collision_tolerance:
            hero_rect.top = forty_ninth_box.bottom
        if abs(hero_rect.right - forty_ninth_box.left) < collision_tolerance:
            hero_rect.right = forty_ninth_box.left
        if abs(hero_rect.left - forty_ninth_box.right) < collision_tolerance:
            hero_rect.left = forty_ninth_box.right


def fiftieth_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fiftieth_box) or fiftieth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fiftieth_box.top) < collision_tolerance:
            hero_rect.bottom = fiftieth_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.right - fiftieth_box.left) < collision_tolerance:
            hero_rect.right = fiftieth_box.left
        if abs(hero_rect.left - fiftieth_box.right) < collision_tolerance:
            hero_rect.left = fiftieth_box.right


def moving_collision_fiftieth_box():
    global fast_moving_rect_speed
    fiftieth_box.x += fast_moving_rect_speed
    if fiftieth_box.x > 1500:
        fast_moving_rect_speed *= -1
    if fiftieth_box.x < 900:
        fast_moving_rect_speed *= -1


def fifty_first_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fifty_first_box) or fifty_first_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fifty_first_box.top) < collision_tolerance:
            hero_rect.bottom = fifty_first_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.top - fifty_first_box.bottom) < collision_tolerance:
            hero_rect.top = fifty_first_box.bottom
            hero_movement = 0
        if abs(hero_rect.right - fifty_first_box.left) < collision_tolerance:
            hero_rect.right = fifty_first_box.left


def fifty_second_box_collision():
    global jump_state, hero_movement, collision_tolerance
    if hero_rect.colliderect(fifty_second_box) or fifty_second_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fifty_second_box.top) < collision_tolerance:
            hero_rect.bottom = fifty_second_box.top
            hero_movement = 0
            jump_state = True
        if abs(hero_rect.left - fifty_second_box.right) < collision_tolerance:
            hero_rect.left = fifty_second_box.right


def level_four_finish_line_collision():
    global level_four_state, collision_tolerance
    if hero_rect.colliderect(level_four_finish_line_rect):
        if abs(hero_rect.right - level_four_finish_line_rect.left) < collision_tolerance:
            level_four_state = True
            click_start.play()


def fifty_third_box_collision():
    global hero_movement, jump_state, collision_tolerance
    if hero_rect.colliderect(fifty_third_box) or fifty_third_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fifty_third_box.top) < collision_tolerance:
            hero_rect.bottom = fifty_third_box.top
            hero_movement = 0
        if abs(hero_rect.top - fifty_third_box.bottom) < collision_tolerance:
            hero_rect.top = fifty_third_box.bottom
            hero_movement = 0
        if abs(hero_rect.left - fifty_third_box.right) < collision_tolerance:
            hero_rect.left = fifty_third_box.right


def fifty_fourth_box_collision():
    global hero_movement, jump_state, collision_tolerance, hero_touch_floor
    if hero_rect.colliderect(fifty_fourth_box) or fifty_fourth_box.colliderect(hero_rect):
        if abs(hero_rect.bottom - fifty_fourth_box.top) < collision_tolerance:
            hero_rect.bottom = fifty_fourth_box.top
            hero_movement = 0
            jump_state = True
            hero_touch_floor = True


pygame.init()
clock = pygame.time.Clock()

screen_width = 1920
screen_height = 1080
screen = pygame.display.set_mode((screen_width, screen_height))

key_surface = pygame.image.load("MyGame/key.png")
key_rect = key_surface.get_rect(center=(1250, 150))

hero_surface = pygame.image.load("MyGame/hero.png").convert()
hero_rect = hero_surface.get_rect(center=(45, 850))

friend_surface = pygame.image.load("MyGame/friend.png").convert()
friend_rect = friend_surface.get_rect(center=(50, 925))

my_love_surface = pygame.image.load("MyGame/my_love.png").convert()

friend_in_case_surface = pygame.image.load("MyGame/friend_in_case.png").convert()
friend_in_case_rect = friend_in_case_surface.get_rect(center=(1500, 193))

enemy_surface_1 = pygame.image.load("MyGame/enemy.png").convert_alpha()
enemy_rect_1 = enemy_surface_1.get_rect(center=(1635, 942))

enemy_surface_2 = pygame.image.load("MyGame/enemy.png").convert_alpha()
enemy_rect_2 = enemy_surface_2.get_rect(center=(1800, 842))

boss_enemy_surface = pygame.image.load("MyGame/boss_enemy.png").convert_alpha()
boss_enemy_rect = boss_enemy_surface.get_rect(center=(2200, 952))

final_boss_surface = pygame.image.load("MyGame/final_boss.png").convert_alpha()
final_boss_rect = final_boss_surface.get_rect(center=(1500, 905))

bullet_surface_1 = pygame.image.load("MyGame/bullet.png").convert_alpha()
bullet_rect_1 = bullet_surface_1.get_rect(center=(1600, 965))

bullet_surface_2 = pygame.image.load("MyGame/bullet.png").convert_alpha()
bullet_rect_2 = bullet_surface_2.get_rect(center=(1765, 860))

boss_bullet_surface = pygame.image.load("MyGame/boss_bullet.png").convert_alpha()
boss_bullet_rect = boss_bullet_surface.get_rect(center=(1450, 975))

finish_line_surface = pygame.image.load("MyGame/finish_line.png").convert()
finish_line_rect = finish_line_surface.get_rect(topleft=(50, 370))

level_four_finish_line_surface = pygame.image.load("MyGame/level_four_finish_line.png").convert()
level_four_finish_line_rect = level_four_finish_line_surface.get_rect(topleft=(screen_width - 100, 85))

start_box = pygame.Rect(0, screen_height - 50, 100, 100)
second_box = pygame.Rect(300, screen_height - 325, 200, 400)
third_box = pygame.Rect(940, screen_height - 100, 50, 125)
fourth_box = pygame.Rect(530, screen_height - 575, 500, 390)
fifth_box = pygame.Rect(1100, screen_height - 400, 50, 600)
sixth_box = pygame.Rect(1750, screen_height - 260, 175, 300)
seventh_box = pygame.Rect(1250, screen_height - 50, 100, 100)
eighth_box = pygame.Rect(1400, screen_height - 900, 80, 780)
ninth_box = pygame.Rect(1480, screen_height - 520, 40, 40)
tenth_box = pygame.Rect(screen_width - 50, 280, 50, 50)
eleventh_box = pygame.Rect(0, 425, 1400, 100)
twelfth_box = pygame.Rect(230, 275, 75, 150)
thirteenth_box = pygame.Rect(510, screen_height - 25, 50, 100)
fourteenth_box = pygame.Rect(0, 250, 450, 100)
fifteenth_box = pygame.Rect(650, 0, 100, 500)
sixteenth_box = pygame.Rect(50, 500, 1200, 200)
seventeenth_box = pygame.Rect(50, screen_height - 20, 20, 50)
eighteenth_box = pygame.Rect(250, screen_height - 200, 20, 50)
nineteenth_box = pygame.Rect(550, screen_height - 80, 20, 50)
twentieth_box = pygame.Rect(850, screen_height - 200, 20, 50)
twenty_first_box = pygame.Rect(1150, screen_height - 80, 20, 50)
twenty_second_box = pygame.Rect(1550, screen_height - 100, 400, 250)
twenty_third_box = pygame.Rect(1700, screen_height - 200, 400, 250)
twenty_fourth_box = pygame.Rect(1750, screen_height / 2 + 50, 175, 50)
twenty_fifth_box = pygame.Rect(375, 410, 75, 90)
twenty_sixth_box = pygame.Rect(150, 410, 75, 75)
twenty_seventh_box = pygame.Rect(850, 250, 1100, 150)
twenty_eighth_box = pygame.Rect(0, 250, 200, 100)
twenty_ninth_box = pygame.Rect(450, 300, 150, 50)
thirtieth_box = pygame.Rect(450, 0, 50, 300)
thirty_first_box = pygame.Rect(750, 250, 50, 750)
thirty_second_box = pygame.Rect(950, 300, 450, 50)
thirty_third_box = pygame.Rect(1050, 0, 50, 300)
thirty_fourth_box = pygame.Rect(1500, 850, 75, 75)
thirty_fifth_box = pygame.Rect(1750, 650, 75, 75)
thirty_sixth_box = pygame.Rect(1600, 450, 75, 75)
thirty_seventh_box = pygame.Rect(0, 950, 300, 50)
thirty_eighth_box = pygame.Rect(300, 300, 75, 850)
thirty_ninth_box = pygame.Rect(0, 600, 275, 50)
fortieth_box = pygame.Rect(375, 1000, 1550, 100)
forty_first_box = pygame.Rect(500, 550, 120, 50)
forty_second_box = pygame.Rect(775, 350, 120, 50)
forty_third_box = pygame.Rect(1050, 350, 120, 50)
forty_fourth_box = pygame.Rect(0, screen_height - 25, 200, 100)
forty_fifth_box = pygame.Rect(0, screen_height - 250, 350, 50)
forty_sixth_box = pygame.Rect(950, 850, 500, 750)
forty_seventh_box = pygame.Rect(screen_width - 100, screen_height - 300, 100, 300)
forty_eighth_box = pygame.Rect(0, screen_height / 2, 1550, 200)
forty_ninth_box = pygame.Rect(1650, 500, 100, 350)
fiftieth_box = pygame.Rect(950, 200, 50, 340)
fifty_first_box = pygame.Rect(250, 100, 1670, 10)
fifty_second_box = pygame.Rect(0, 250, 50, 290)
fifty_third_box = pygame.Rect(0, 125, 100, 50)
fifty_fourth_box = pygame.Rect(0, screen_height - 50, screen_width, 100)
fifty_fifth_box = pygame.Rect(screen_width - 75, 150, 75, 50)

tutorial_box = pygame.Rect(0, screen_height - 50, 750, 250)
tutorial_box_two = pygame.Rect(1200, screen_height - 50, 750, 250)
tutorial_box_three = pygame.Rect(770, screen_height - 315, 400, 50)

find_the_key_level_finish_box = pygame.Rect(0, 15, 10, 220)

square_moving_box = pygame.Rect(500, 100, 50, 325)

light_grey = pygame.Color("grey12")
start_color = (50, 50, 100)
RED = (255, 30, 30)
YELLOW = (253, 210, 0)
BLUE = (0, 60, 100)
WHITE = (98, 98, 98)
GREEN = (0, 80, 60)
PINK = (130, 20, 93)
LIGHT_BLUE = (40, 46, 94)

intro_font = pygame.font.Font("freesansbold.ttf", 50)
tutorial_font = pygame.font.Font("freesansbold.ttf", 25)
small_font = pygame.font.Font("freesansbold.ttf", 25)
medium_font = pygame.font.Font("freesansbold.ttf", 50)
bigfont = pygame.font.Font("freesansbold.ttf", 120)

intro_text = intro_font.render("CLICK ON THE SCREEN TO START", True, pygame.Color("white"))

tutorial_text = tutorial_font.render("CLICK TO START FIRST LEVEL", False, pygame.Color("White"))
TUTORIAL_text = bigfont.render("TUTORIAL", True, pygame.Color("white"))
friend_run_text = small_font.render("WHERE DID HE GO?", False, pygame.Color("White"))

GRAVITY = 0.25
hero_movement = 0
hero_speed = 0
jump_state = False

moving_rect_speed = 7
fast_moving_rect_speed = 10
collision_tolerance = 20
sound = pygame.mixer.Sound("MyGame/jump.wav")
dead_sound = pygame.mixer.Sound("MyGame/dead.wav")
click_start = pygame.mixer.Sound("MyGame/clickstart2.wav")
gunshot = pygame.mixer.Sound("MyGame/shotsound2.wav")
boss_gunshot = pygame.mixer.Sound("MyGame/bossshot.wav")

BG_intro_surface = pygame.image.load("MyGame/BG_intro_2.png").convert()
BG_tutorial_surface = pygame.image.load("MyGame/BG_tutorial.png").convert()

BG_first_cutscene_1_surface = pygame.image.load("MyGame/First_cutscene_1.png").convert()
BG_first_cutscene_2_surface = pygame.image.load("MyGame/First_cutscene_2.png").convert()
BG_first_cutscene_3_surface = pygame.image.load("MyGame/First_cutscene_3.png").convert()
BG_first_cutscene_4_surface = pygame.image.load("MyGame/First_cutscene_4.png").convert()
BG_first_cutscene_5_surface = pygame.image.load("MyGame/First_cutscene_5.png").convert()
BG_first_cutscene_6_surface = pygame.image.load("MyGame/First_cutscene_6.png").convert()

BG_key_level_arrow_surface = pygame.image.load("MyGame/find_the_key_level_arrow.PNG").convert()

BG_second_cutscene_1_surface = pygame.image.load("MyGame/Second_cutscene_1.png").convert()
BG_second_cutscene_2_surface = pygame.image.load("MyGame/Second_cutscene_2.png").convert()
BG_second_cutscene_3_surface = pygame.image.load("MyGame/Second_cutscene_3.png").convert()
BG_second_cutscene_4_surface = pygame.image.load("MyGame/Second_cutscene_4.png").convert()

BG_callable_friend_surface = pygame.image.load("MyGame/third_level_call_friend.png").convert()

BG_zero_cutscene_surface = pygame.image.load("MyGame/Zero_cutscene_1.png").convert()

BG_jump_on_boss_surface = pygame.image.load("MyGame/jump_on_boss.PNG").convert()

BG_third_cutscene_1_surface = pygame.image.load("MyGame/Third_cutscene_1.png").convert()
BG_third_cutscene_2_surface = pygame.image.load("MyGame/Third_cutscene_2.png").convert()
BG_third_cutscene_3_surface = pygame.image.load("MyGame/Third_cutscene_3.png").convert()
BG_third_cutscene_4_surface = pygame.image.load("MyGame/Third_cutscene_4.png").convert()

BG_fourth_cutscene_1_surface = pygame.image.load("MyGame/Fourth_cutscene_1.png").convert()

BG_level_five_surface = pygame.image.load("MyGame/level_five_screen.PNG").convert()
BG_level_five_2_surface = pygame.image.load("MyGame/level_five_screen_2.PNG").convert()
BG_level_five_3_surface = pygame.image.load("MyGame/level_five_screen_3.PNG").convert()
BG_level_five_4_surface = pygame.image.load("MyGame/level_five_screen_4.PNG").convert()
BG_level_five_5_surface = pygame.image.load("MyGame/level_five_screen_5.PNG").convert()
BG_level_five_6_surface = pygame.image.load("MyGame/level_five_screen_6.PNG").convert()


GB_level_five_end_surface = pygame.image.load("MyGame/level_five_end.png").convert()

game_state = GameState()

call_friend_state = False

HARD_MODE = False

level_state = "first_level"
level_two_state = False
level_find_the_key_state = False
first_cutscene_state = False
level_three_state = False
level_four_state = False

level_three_text_ready = False
level_three_text_disappear = True

friend_speed = 0
boss_enemy_speed = 0
boss_bullet_speed = 12
boss_stops_state = False
bullet_speed = 9
bullet_1_state = True
bullet_2_state = True
key_state = True
key_level_arrow_state = False

boss_can_go = True
boss_bullet_ready = False
boss_bullet_shoot = False
jump_on_boss_state = False

reset_hero_speed_0 = False

hero_touch_floor = False

click_ready = False

x = 1
endgame_state = False

while True:
    game_state.state_manager()
    clock.tick(60)