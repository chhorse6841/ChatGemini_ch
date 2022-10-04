# Set start and end dates
START_DATE="2022-10-04"
END_DATE="2023-02-04"

commit_messages=(
    "Upgrade Gemini version to 1.5 Pro (#17)"
    "Merge remote-tracking branch 'origin/main'"
    "Android app icon"
    "chore: Issues marked by "stat:import" OR "stat:imported" labels won't be marked as "Stale" by automation"
    "Update dependencies to the latest versions"
    "Fix dispatcher error on desktop"
    "Add dark mode support for the settings page"
    "Chat feature"
    "fix: AnticipatedNetworkVariable not updating previous value [MTTB-1036] (back port)"
    "chore: turn on verbose for world position stays test"
    "perf: reduce networkbehaviourilpp type resolution time"
)

git add .

# Loop through each day from START_DATE to END_DATE
while [ "$(date -d "$START_DATE" +%Y-%m-%d)" != "$(date -d "$END_DATE + 1 day" +%Y-%m-%d)" ]; do
    # Decide randomly if this day should have commits (3-4 active days per week)
    if [ $((RANDOM % 7)) -lt 4 ]; then  # 4/7 chance of committing
        # Generate a random number of commits for the day (1 to 3 commits)
        NUM_COMMITS=$((RANDOM % 3 + 1))

        for ((i = 1; i <= NUM_COMMITS; i++)); do
            # Generate a random time during the day
            HOUR=$((RANDOM % 24))
            MINUTE=$((RANDOM % 60))
            SECOND=$((RANDOM % 60))

            # Set the commit date and time
            COMMIT_DATE="$START_DATE $HOUR:$MINUTE:$SECOND"
            commit_message=${commit_messages[$RANDOM % ${#commit_messages[@]}]}

            # Create a commit
            export GIT_AUTHOR_DATE="$COMMIT_DATE"
            export GIT_COMMITTER_DATE="$COMMIT_DATE"
            echo "$commit_message" > commit.txt
            git add commit.txt -f
            git commit -m "$commit_message"
        done
    fi

    # Increment the date by 1 day
    START_DATE=$(date -I -d "$START_DATE + 1 day")
done