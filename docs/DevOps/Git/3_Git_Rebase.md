<div class="git-container" markdown="1">

<div class="diagram">
    <div class="title-badge">THE PROBLEM</div>
    <h2>What Happened? 🤔</h2>
    
    <svg viewBox="0 0 800 400">
        <!-- Main line -->
        <path d="M 50 200 Q 100 195 150 200" class="line"/>
        <path d="M 150 200 Q 200 205 250 200" class="line"/>
        <path d="M 250 200 Q 300 198 350 200" class="line"/>
        
        <!-- Branch to remote -->
        <path d="M 350 200 Q 400 180 450 150" class="line" stroke="#ff6b6b"/>
        <path d="M 450 150 Q 500 140 550 150" class="line" stroke="#ff6b6b"/>
        <path d="M 550 150 Q 600 155 650 150" class="line" stroke="#ff6b6b"/>
        
        <!-- Branch to local -->
        <path d="M 350 200 Q 400 220 450 250" class="line" stroke="#ffd93d"/>
        <path d="M 450 250 Q 500 260 550 250" class="line" stroke="#ffd93d"/>
        
        <!-- Commits A, B, C -->
        <circle cx="100" cy="200" r="30" class="commit"/>
        <text x="100" y="210" text-anchor="middle">A</text>
        
        <circle cx="200" cy="200" r="30" class="commit"/>
        <text x="200" y="210" text-anchor="middle">B</text>
        
        <circle cx="300" cy="200" r="30" class="commit"/>
        <text x="300" y="210" text-anchor="middle">C</text>
        
        <!-- Remote commits -->
        <circle cx="500" cy="150" r="30" class="commit commit-remote"/>
        <text x="500" y="160" text-anchor="middle">E</text>
        
        <circle cx="650" cy="150" r="30" class="commit commit-remote"/>
        <text x="650" y="160" text-anchor="middle">F</text>
        
        <!-- Local commit -->
        <circle cx="550" cy="250" r="30" class="commit commit-local"/>
        <text x="550" y="260" text-anchor="middle">D</text>
        
        <!-- Labels -->
        <text x="720" y="160" font-size="24" fill="#ff6b6b">← Remote (GitHub)</text>
        <text x="620" y="260" font-size="24" fill="#d4a000">← Local (You)</text>
        <text x="50" y="150" font-size="20" fill="#666">Common history</text>
    </svg>
    
    <div class="description">
        <strong>What happened:</strong><br>
        • You both started with A → B → C<br>
        • Someone else pushed E and F to remote 🔴<br>
        • You created commit D locally 🟡<br>
        • Now: DIVERGED! Two different versions exist!
    </div>
</div>

</div>