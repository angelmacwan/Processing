// todo: make is faster by either creating a shader or try using P3D first

import java.util.ArrayList;

class ParticleLifeSimulator {
    int numParticleTypes = 5;

    float[] particleColors;
    float[][] interactionMatrix;
    
    // Particle parameters
    float minDistance = 60;  // Minimum distance between particles
    float maxDistance = 350; // Maximum interaction distance
    float maxVelocity = 3;   // Maximum velocity for particles
    int numParticles = 1000;  // Total number of particles
    
    ArrayList<Particle> particles;
    
    ParticleLifeSimulator() {
        particleColors = new float[numParticleTypes];
        
        // todo: add better colors
        // use pre defined color palets and a default color once you run out of indexes..
        for (int i = 0; i < numParticleTypes; i++) {
            particleColors[i] = map(i, 0, numParticleTypes, 0, 255);
        }

        // todo: make this into its own function
        interactionMatrix = new float[numParticleTypes][numParticleTypes];
        for (int i = 0; i < numParticleTypes; i++) {
            for (int j = 0; j < numParticleTypes; j++) {
                interactionMatrix[i][j] = random(-1, 1);
            }
        }
        
        particles = new ArrayList<>();
        for (int i = 0; i < numParticles; i++) {
            particles.add(new Particle(random(height), random(height), int(random(numParticleTypes))));
        }
    }

    float calculateShortestDistance(float x1, float y1, float x2, float y2) {
        float dx = min(
            abs(x2 - x1), 
            min(width - abs(x2 - x1), width - abs(x1 - x2))
        );
        float dy = min(
            abs(y2 - y1), 
            min(height - abs(y2 - y1), height - abs(y1 - y2))
        );
        return sqrt(dx*dx + dy*dy);
    }
    
    void update() {
        for (Particle p1 : particles) {
            float totalForceX = 0;
            float totalForceY = 0;
            
            for (Particle p2 : particles) {
                if (p1 == p2) continue;
            
                // Calculate shortest distance across wrapped boundaries
                float distance = calculateShortestDistance(p1.x, p1.y, p2.x, p2.y);
                
                if (distance > maxDistance) continue;
                
                // Determine correct direction vector considering wrapping
                float dx = p2.x - p1.x;
                if (abs(dx) > width/2) {
                    dx = (width - abs(dx)) * (dx < 0 ? 1 : -1);
                }
                
                float dy = p2.y - p1.y;
                if (abs(dy) > height/2) {
                    dy = (height - abs(dy)) * (dy < 0 ? 1 : -1);
                }
                
                // Normalize direction
                float directionLength = sqrt(dx*dx + dy*dy);
                
                float force = calculateForce(p1.type, p2.type, distance);
                
                float forceX = force * (dx / directionLength);
                float forceY = force * (dy / directionLength);
                
                totalForceX += forceX;
                totalForceY += forceY;
            }
            
            
            // Update particle velocity
            p1.vx += totalForceX;
            p1.vy += totalForceY;
            
            // Limit velocity
            float velocity = sqrt(p1.vx*p1.vx + p1.vy*p1.vy);
            if (velocity > maxVelocity) {
                p1.vx = (p1.vx / velocity) * maxVelocity;
                p1.vy = (p1.vy / velocity) * maxVelocity;
            }
            
            // Damping
            p1.vx *= 0.99;
            p1.vy *= 0.99;

            // Update position
            p1.x += p1.vx;
            p1.y += p1.vy;

            
            // Update position
            p1.x += p1.vx;
            p1.y += p1.vy;
            
            // Wrap around screen
            p1.x = (p1.x + width) % width;
            p1.y = (p1.y + height) % height;
        }
    }
    
    float calculateForce(int type1, int type2, float distance) {
        // Interaction based on particle types and distance
        float interaction = interactionMatrix[type1][type2];
        
        // Repulsion at close distances
        if (distance < minDistance) {
            return -1 * (minDistance - distance) / minDistance;
        }
        
        // Attractive or repulsive force based on interaction matrix
        return interaction * (1 - abs(distance - maxDistance/2) / (maxDistance/2));
    }
    
    void display() {
        colorMode(HSB, 255);
        
        for (Particle p : particles) {
            // Color based on particle type
            fill(particleColors[p.type], 200, 200);
            noStroke();
            circle(p.x, p.y, 6);
        }
    }
}

class Particle {
    float x, y;
    float vx, vy;
    int type;
    
    Particle(float x, float y, int type) {
        this.x = x;
        this.y = y;
        this.type = type;
        this.vx = 0;
        this.vy = 0;
    }
}

ParticleLifeSimulator simulator;

void setup() {
    size(900, 900);
    simulator = new ParticleLifeSimulator();
}

void draw() {
    background(0);
    simulator.update();
    simulator.display();

    // better keep this off 
    saveFrame("./images/f-######.png");
}

void mousePressed() {
    for (int i = 0; i < simulator.numParticleTypes; i++) {
        for (int j = 0; j < simulator.numParticleTypes; j++) {
            simulator.interactionMatrix[i][j] = random(-1, 1);
        }
    }
}
