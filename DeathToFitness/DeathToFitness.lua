-- Hard-coding a set number of exercise that the user can be told to do
local exercises = {"push-ups", "sit-ups", "squats", "second(s) of planking", "lunges"}

-- Initalizing the event frame
local Exercise_EventFrame = CreateFrame("Frame")

-- Setting the event frame to listen for a player death
Exercise_EventFrame:RegisterEvent("PLAYER_DEAD")

-- Creating the script to execute when the event is triggered
Exercise_EventFrame:SetScript("OnEvent",
    function(self, event, ...)
        -- Initalize current and max boss health pools, along with the number of the exercise to do and the exercise itself
        local currentHealth = 0
        local maxHealth = 0
        local calculatedNum = 0
        local exerciseToDo = ""
        
        -- If there is at least one boss (This will prevent anything from printing when dying to trash)
        if UnitHealth("boss1") ~= 0 then
            -- If there are 4 bosses
            if UnitHealth("boss4") ~= 0 then
                -- Sum the current and max health of all bosses
                currentHealth = UnitHealth("boss1") + UnitHealth("boss2") + UnitHealth("boss3") + UnitHealth("boss4")
                maxHealth = UnitHealthMax("boss1") +  UnitHealthMax("boss2") + UnitHealthMax("boss3") + UnitHealthMax("boss4")
            -- If there are 3 bosses
            elseif UnitHealth("boss3") ~= 0 then
                -- Sum the current and max health of all bosses
                currentHealth = UnitHealth("boss1") + UnitHealth("boss2") + UnitHealth("boss3")
                maxHealth = UnitHealthMax("boss1") +  UnitHealthMax("boss2") + UnitHealthMax("boss3")
            -- If there are 2 bosses
            elseif UnitHealth("boss2") ~= 0 then
                -- Sum the current and max health of all bosses
                currentHealth = UnitHealth("boss1") + UnitHealth("boss2")
                maxHealth = UnitHealthMax("boss1") +  UnitHealthMax("boss2")
            -- If there is only 1 boss
            else
                -- Get the boss' current and max health
                currentHealth = UnitHealth("boss1")
                maxHealth = UnitHealthMax("boss1")
            end

            -- Calculate the amount of the exercise to do
            calculatedNum = math.floor(((currentHealth / maxHealth) * 100) / 2)
            -- Randomly get an exercise to do
            exerciseToDo = exercises[math.random(0, table.getn(exercises))]

            -- Create/modify a popup dialog which contains the amount of exercise to do
            StaticPopupDialogs["WORKOUT_DIALOG"] = {
                text = "You need to do " .. calculatedNum .. " " .. exerciseToDo,
                button1 = OKAY,
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                preferredIndex = 3,
            }

            -- Display the dialog box
            StaticPopup_Show ("WORKOUT_DIALOG")


            -- Print the amount of exercise to do to the chat window (Used for debugging)
            --print("You need to do " .. calculatedNum .. " " .. exerciseToDo)
		end
    end)