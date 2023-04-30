// dear imgui: standalone example application for GLFW + OpenGL 3, using programmable pipeline
// If you are new to dear imgui, see examples/README.txt and documentation at the top of imgui.cpp.
// (GLFW is a cross-platform general purpose library for handling windows, inputs, OpenGL/Vulkan graphics context creation, etc.)

#include "imgui.h"
#include "imgui_impl/imgui_impl_glfw.h"
#include "imgui_impl/imgui_impl_opengl3.h"
#include <stdio.h>
#include <iostream>
#include <filesystem>
#include "Shader.h"
#include "stb_image.h"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>



#define IMGUI_IMPL_OPENGL_LOADER_GLAD

//// About OpenGL function loaders: modern OpenGL doesn't have a standard header file and requires individual function pointers to be loaded manually. 
//// Helper libraries are often used for this purpose! Here we are supporting a few common ones: gl3w, glew, glad.
//// You may use another loader/header of your choice (glext, glLoadGen, etc.), or chose to manually implement your own.
#if defined(IMGUI_IMPL_OPENGL_LOADER_GL3W)
#include <GL/gl3w.h>    // Initialize with gl3wInit()
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLEW)
#include <GL/glew.h>    // Initialize with glewInit()
#elif defined(IMGUI_IMPL_OPENGL_LOADER_GLAD)
#include <glad/glad.h>  // Initialize with gladLoadGL()
#else
#include IMGUI_IMPL_OPENGL_LOADER_CUSTOM
#endif

#include <GLFW/glfw3.h> // Include glfw3.h after our OpenGL definitions
#include <spdlog/spdlog.h>


void framebuffer_size_callback(GLFWwindow* window, int width, int height);
void processInput(GLFWwindow* window);
void create_tetrahedron(int iterations, glm::mat4 model, Shader ourShader,
    float translate_x, float translate_y, float translate_z, int current_iterations = 0);

// settings
const unsigned int SCR_WIDTH = 1000;
const unsigned int SCR_HEIGHT = 1000;
int requiredIterations = 3;
int rotation_x = 0;
int rotation_y = 0;
const char* glsl_version = "#version 430";
glm::vec4 tetrahedronColor = glm::vec4(1.0f, 1.0f, 1.0f, 1.0f);
float startTime = 0, endTime = 0, deltaTime = 0;

int main()
{
    // glfw: initialize and configure
    // ------------------------------
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

#ifdef __APPLE__
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

    // glfw window creation
    // --------------------
    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "Sierpinski Tetrahedron", NULL, NULL);
    if (window == NULL)
    {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    // glad: load all OpenGL function pointers
    // ---------------------------------------
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
    {
        std::cout << "Failed to initialize GLAD" << std::endl;
        return -1;
    }

    // configure global opengl state
    // -----------------------------
    glEnable(GL_DEPTH_TEST);

    // build and compile our shader zprogram
    // ------------------------------------
    Shader ourShader("./res/shaders/basic.vert", "./res/shaders/basic.frag");

    // set up vertex data (and buffer(s)) and configure vertex attributes
    // ------------------------------------------------------------------
    float vertices[] = {
        //FRONT
        -1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.5f, 0.0f,  //left corner
         1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.0f, 1.0f,  //right corner
         0.0f,  1.0f,  0.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        1.0f, 1.0f,  //top corner

         //LEFT BACK 
        -1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.5f, 0.0f,  //left corner
         0.0f, -1.0f, -1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.0f, 1.0f,  //back corner
         0.0f,  1.0f,  0.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        1.0f, 1.0f,  //top corner

         //RIGHT BACK
         1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.5f, 0.0f,  //right corner
         0.0f, -1.0f, -1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.0f, 1.0f,  //back corner
         0.0f,  1.0f,  0.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        1.0f, 1.0f,  //top corner

         //BOTTOM
        -1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.5f, 0.0f,  //left corner
         1.0f, -1.0f,  1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        0.0f, 1.0f,  //right corner
         0.0f, -1.0f, -1.0f,     tetrahedronColor.x,   tetrahedronColor.y,   tetrahedronColor.z,        1.0f, 1.0f,  //back corner
    };
    unsigned int VBO, VAO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);

    glBindVertexArray(VAO);

    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    // position attribute
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)0);
    glEnableVertexAttribArray(0);
    // color attribute
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    // texture coord attribute
    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 8 * sizeof(float), (void*)(6 * sizeof(float)));
    glEnableVertexAttribArray(2);


    // texture creation 
    // -------------------------
    unsigned int texture1;
    // texture 1
    // ---------
    glGenTextures(1, &texture1);
    glBindTexture(GL_TEXTURE_2D, texture1);
    // set the texture wrapping parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    // set texture filtering parameters
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    // load image, create texture and generate mipmaps
    int width, height, nrChannels;
    stbi_set_flip_vertically_on_load(true); // tell stb_image.h to flip loaded texture's on the y-axis.
    unsigned char* data = stbi_load("./res/textures/brick.jpg", &width, &height, &nrChannels, 0);
    if (data)
    {
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data);
        glGenerateMipmap(GL_TEXTURE_2D);
    }
    else
    {
        std::cout << "Failed to load texture" << std::endl;
    }
    stbi_image_free(data);
    

    //----------------------------------------------------------------------------------------------------- 
    //GUI
    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui_ImplGlfw_InitForOpenGL(window, true);
    ImGui_ImplOpenGL3_Init(glsl_version);

    ImGui::StyleColorsDark();

    ImVec4 clear_color = ImVec4(0.69f, 0.69f, 0.41f, 1.00f);


    // tell opengl for each sampler to which texture unit it belongs to (only has to be done once)
    // -------------------------------------------------------------------------------------------
    ourShader.use();
    ourShader.setInt("texture1", 0);


    startTime = glfwGetTime();
    // render loop
    // -----------
    while (!glfwWindowShouldClose(window))
    {// input
        processInput(window);

        ImGui_ImplOpenGL3_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        {
            ImGui::Begin("Tooltip");

            ImGui::Text("Iterations and rotation.");

            ImGui::SliderInt("Iterations", &requiredIterations, 0, 6);

            ImGui::ColorEdit3("clear color", (float*)&tetrahedronColor);

            ImGui::SliderInt("Rotation x", &rotation_x, 0, 360);

            ImGui::SliderInt("Rotation y", &rotation_y, 0, 360);

            ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
            ImGui::End();
        }

        //COLOR CHANGE
        for (int i = 0; i < 12; i++)
        {
            vertices[3 + 8 * i] = tetrahedronColor.x;
            vertices[4 + 8 * i] = tetrahedronColor.y;
            vertices[5 + 8 * i] = tetrahedronColor.z;
        }
        
        glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(vertices), vertices);

       
        
        //TEXTURE POSITION CHANGE
        /*for (int i = 0; i < 12; i++)
        {
            currentTextureXPosition = vertices[6 + 8 * i];
            vertices[6 + 8 * i] = abs(sin((endTime - startTime) + currentTextureXPosition));
        }*/

        

        // render
        // ------
        ImGui::Render();
        int display_w, display_h;
        glfwMakeContextCurrent(window);
        glfwGetFramebufferSize(window, &display_w, &display_h);
        glViewport(0, 0, display_w, display_h);
        glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());
        glClearColor(0.1f, 0.6f, 0.2f, 1.0f);

        // bind textures on corresponding texture units
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);

        // activate shader
        ourShader.use();

        endTime = glfwGetTime();
        deltaTime = endTime - startTime;

        std::cout << endTime - startTime << std::endl;
        ourShader.setFloat("deltaTime", deltaTime);

        // create transformations
        glm::mat4 view = glm::mat4(1.0f);
        glm::mat4 projection = glm::mat4(1.0f);
        view = glm::translate(view, glm::vec3(0.0f, 0.0f, -4.0f));
        projection = glm::perspective(glm::radians(45.0f), (float)SCR_WIDTH / (float)SCR_HEIGHT, 0.1f, 100.0f);
        ourShader.setMat4("projection", projection);
        ourShader.setMat4("view", view);

        // Binding of VAO
        glBindVertexArray(VAO);

        // Drawing
        glm::mat4 model = glm::mat4(1.0f); // make sure to initialize matrix to identity matrix first
        model = glm::rotate(model, glm::radians((float)rotation_y), glm::vec3(0.0f, 1.0f, 0.0f));
        model = glm::rotate(model, glm::radians((float)rotation_x), glm::vec3(1.0f, 0.0f, 0.0f));
        model = glm::translate(model, glm::vec3(0, 1, 0));
        create_tetrahedron(requiredIterations, model, ourShader, 0, 0, 0);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        // -------------------------------------------------------------------------------
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // optional: de-allocate all resources once they've outlived their purpose:
    // ------------------------------------------------------------------------
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);

    // glfw: terminate, clearing all previously allocated GLFW resources.
    // ------------------------------------------------------------------
    glfwTerminate();
    return 0;
}


void processInput(GLFWwindow* window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
}


void create_tetrahedron(int num_iter, glm::mat4 model, Shader ourShader,
    float x_movement, float y_movement, float z_movement, int movement)
{
    if (num_iter == 0)
    {
        model = glm::translate(model, glm::vec3(x_movement, y_movement, z_movement));
        ourShader.setMat4("model", model);
        glDrawArrays(GL_TRIANGLES, 0, 12);
    }
   
    else
    {
        if (movement == 0)
            movement++;
        else
        {
            movement *= 2;
        }
        model = glm::scale(model, glm::vec3(0.5, 0.5, 0.5));
        create_tetrahedron(num_iter - 1, model, ourShader,
            x_movement, y_movement, z_movement, movement);
        create_tetrahedron(num_iter - 1, model, ourShader,
            x_movement - movement, y_movement - movement * 2, z_movement + movement, movement);
        create_tetrahedron(num_iter - 1, model, ourShader,
            x_movement + movement, y_movement - movement * 2, z_movement + movement, movement);
        create_tetrahedron(num_iter - 1, model, ourShader,
            x_movement, y_movement - movement * 2, z_movement - movement, movement);
    }
}
