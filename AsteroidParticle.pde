class AsteroidParticle extends Particle {
    public AsteroidParticle(float argX, float argY, float argVelocity, float argVelocityAngle, int argColor) {
        super(argX, argY, argVelocity, argVelocityAngle, argColor);
        customShape = true;
        // Initializes the asteroid shape
        corners = 8;
        xCorners = new int[]{-5, 0, 5, 5, 5, 0, -5, -5};
        yCorners = new int[]{-5, -5, -5, 0, 5, 5, 5, 0};
        // Randomizes asteroid shape
        yCorners[1] += (int)(5 * Math.random());
        xCorners[3] += (int)(5 * Math.random());
        yCorners[5] -= (int)(5 * Math.random());
        xCorners[7] -= (int)(5 * Math.random());
    }
}